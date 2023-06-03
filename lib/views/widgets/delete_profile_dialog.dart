import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teams_multi_instances/bloc/process/process_bloc.dart';
import 'package:teams_multi_instances/bloc/profile/profile_bloc.dart';
import 'package:teams_multi_instances/models/profile_model.dart';

class DeleteProfileDialog extends StatelessWidget {
  final ProfileModel profileModel;

  const DeleteProfileDialog({Key? key, required this.profileModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProcessBloc, ProcessState>(
      listener: (context, state) {
        if (state is ProcessRemoveDirectorySuccessState) {
          BlocProvider.of<ProfileBloc>(context, listen: false).add(
            ProfileRemoveEvent(profileModel: profileModel),
          );
          Navigator.of(context).pop();
        }
      },
      child: AlertDialog(
        title: const Text('Delete Profile'),
        icon: const Icon(Icons.warning),
        content: const Text(
            'Do you want to delete the profile including directory?',
            textAlign: TextAlign.center),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              BlocProvider.of<ProcessBloc>(context, listen: false).add(
                ProcessRemoveDirectoryEvent(profileModel: profileModel),
              );
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }
}
