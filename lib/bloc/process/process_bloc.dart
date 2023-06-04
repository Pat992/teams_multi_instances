import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:teams_multi_instances/models/failure_model.dart';
import 'package:teams_multi_instances/models/profile_model.dart';

part 'process_event.dart';

part 'process_state.dart';

class ProcessBloc extends Bloc<ProcessEvent, ProcessState> {
  String teamBaseDirectory = '';

  ProcessBloc() : super(ProcessInitial()) {
    on<ProcessInitEvent>((event, emit) async {
      try {
        emit(ProcessLoadingState());

        final res = await Process.run(
          'powershell',
          [r'Write-Output("$env:LOCALAPPDATA\Microsoft\Teams")'],
        );

        if (res.stderr != null && res.stderr != '') {
          throw Exception(res.stderr);
        }
        final String resStr = res.stdout;
        teamBaseDirectory = resStr.trim();
        emit(ProcessGetTeamsBaseDirectoryState(path: teamBaseDirectory));
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
          throw Exception(res.stderr);
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

        if (event.profileModel.profileName.isEmpty) {
          emit(
            const ProcessFailureState(
              failureModel: FailureModel(
                title: 'Empty profile name',
                description: 'The profile name needs to be set.',
              ),
            ),
          );
          return;
        }

        final res = await Process.run(
          'powershell',
          ['mkdir ${event.profileModel.profileFolder}'],
        );
        if (res.stderr != null && res.stderr != '') {
          throw Exception(res.stderr);
        }
        emit(ProcessMakeDirectorySuccessState());
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
          ['rmdir -Path ${event.profileModel.profileFolder} -Recurse'],
        );

        if (res.stderr != null && res.stderr != '') {
          throw Exception(res.stderr);
        }
        emit(ProcessRemoveDirectorySuccessState());
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

        String command = '';
        if (event.profileModel.id != 'main_profile') {
          command = '''
        \$oldProfile=\$Env:USERPROFILE
        \$Env:USERPROFILE="${event.profileModel.profileFolder}"
        Start-Process "\$oldProfile\\AppData\\Local\\Microsoft\\Teams\\Update.exe" --processStart="Teams.exe"
        ''';
        } else {
          command = r'''
        Start-Process "$Env:USERPROFILE\AppData\Local\Microsoft\Teams\Update.exe" --processStart="Teams.exe"
        ''';
        }

        final res = await Process.run(
          'powershell',
          [
            command,
          ],
        );

        if (res.stderr != null && res.stderr != '') {
          throw Exception(res.stderr);
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
