import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teams_multi_instances/bloc/process/process_bloc.dart';
import 'package:teams_multi_instances/models/profile_model.dart';

class OpenAllButton extends StatelessWidget {
  final List<ProfileModel> profileModels;

  const OpenAllButton({
    Key? key,
    required this.profileModels,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: ElevatedButton(
        onPressed: () {
          for (final profileModel in profileModels) {
            BlocProvider.of<ProcessBloc>(context).add(
              ProcessLaunchTeamsEvent(profileModel: profileModel),
            );
          }
        },
        child: const Text('Open all'),
      ),
    );
  }
}
