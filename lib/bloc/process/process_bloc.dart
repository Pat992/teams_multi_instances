import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:teams_multi_instances/models/failure_model.dart';
import 'package:teams_multi_instances/models/profile_model.dart';

part 'process_event.dart';

part 'process_state.dart';

class ProcessBloc extends Bloc<ProcessEvent, ProcessState> {
  ProcessBloc() : super(ProcessInitial()) {
    on<ProcessInitEvent>((event, emit) async {
      try {
        emit(ProcessLoadingState());

        final res = await Process.run(
          'powershell',
          [r'Write-Output($env:LOCALAPPDATA)'],
        );

        if (res.stderr != null && res.stderr != '') {
          throw Exception();
        }
        final String resStr = res.stdout;
        emit(ProcessGetTeamsBaseDirectoryState(path: resStr.trim()));
      } catch (e) {
        emit(
          ProcessFailureState(
            failureModel: FailureModel(
                title: 'Teams base directory not found',
                description: e.toString()),
          ),
        );
      }
    });

    on<ProcessOpenDirectoryEvent>((event, emit) async {
      try {
        emit(ProcessLoadingState());

        final res = await Process.run(
          'powershell',
          ['explorer "${event.profileModel.profileFolder}"'],
        );

        if (res.stderr != null && res.stderr != '') {
          throw Exception();
        }
        emit(ProcessSuccessState());
      } catch (e) {
        emit(
          ProcessFailureState(
            failureModel: FailureModel(
                title: 'Error opening profile directory',
                description: e.toString()),
          ),
        );
      }
    });

    on<ProcessMakeDirectoryEvent>((event, emit) async {
      try {
        emit(ProcessLoadingState());

        final res = await Process.run(
          'powershell',
          ['mkdir ${event.profileModel.profileFolder}'],
        );

        if (res.stderr != null && res.stderr != '') {
          throw Exception();
        }
        emit(ProcessSuccessState());
      } catch (e) {
        emit(
          ProcessFailureState(
            failureModel: FailureModel(
                title: 'Error creating profile directory',
                description: e.toString()),
          ),
        );
      }
    });

    on<ProcessRemoveDirectoryEvent>((event, emit) async {
      try {
        emit(ProcessLoadingState());

        final res = await Process.run(
          'powershell',
          ['rmdir ${event.profileModel.profileFolder}'],
        );

        if (res.stderr != null && res.stderr != '') {
          throw Exception();
        }
        emit(ProcessSuccessState());
      } catch (e) {
        emit(
          ProcessFailureState(
            failureModel: FailureModel(
                title: 'Error creating profile directory',
                description: e.toString()),
          ),
        );
      }
    });

    on<ProcessLaunchTeamsEvent>((event, emit) async {
      try {
        emit(ProcessLoadingState());

        final command = '''
        \$teamsPath="\$Env:USERPROFILE\\AppData\\Local\\Microsoft\\Teams\\Update.exe"
        \$Env:USERPROFILE="${event.profileModel.profileFolder}\\%~n0"
        \$teamsPath --processStart "Teams.exe"
        ''';

        final res = await Process.run(
          'powershell',
          [
            command,
          ],
        );

        if (res.stderr != null && res.stderr != '') {
          throw Exception();
        }

        emit(ProcessSuccessState());
      } catch (e) {
        emit(
          ProcessFailureState(
            failureModel: FailureModel(
                title: 'Error creating profile directory',
                description: e.toString()),
          ),
        );
      }
    });
  }
}
