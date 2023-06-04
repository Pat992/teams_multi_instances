import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teams_multi_instances/bloc/process/process_bloc.dart';
import 'package:teams_multi_instances/bloc/profile/profile_bloc.dart';
import 'package:teams_multi_instances/models/profile_model.dart';

class AddProfileDialog extends StatelessWidget {
  const AddProfileDialog({Key? key}) : super(key: key);

  ProfileModel createProfile({
    required String profileName,
    required String baseDirectory,
  }) {
    String id = profileName.replaceAll(RegExp('[^A-Za-z0-9]'), '');

    return ProfileModel(
      id: id,
      profileName: profileName,
      profileFolder: '$baseDirectory\\$id',
    );
  }

  void addProfile({
    required ProfileModel profileModel,
    required BuildContext context,
  }) {
    BlocProvider.of<ProcessBloc>(context, listen: false).add(
      ProcessMakeDirectoryEvent(profileModel: profileModel),
    );
  }

  @override
  Widget build(BuildContext context) {
    String teamsBaseDirectory =
        BlocProvider.of<ProcessBloc>(context).teamBaseDirectory;
    String profileName = '';
    return BlocBuilder<ProcessBloc, ProcessState>(
      builder: (context, state) {
        if (state is ProcessMakeDirectorySuccessState) {
          final profileModel = createProfile(
            profileName: profileName,
            baseDirectory: teamsBaseDirectory,
          );

          BlocProvider.of<ProcessBloc>(context, listen: false)
              .add(ProcessInitEvent());
          BlocProvider.of<ProfileBloc>(context, listen: false)
              .add(ProfileAddEvent(profileModel: profileModel));

          Navigator.of(context).pop();
        }
        return AlertDialog(
          title: const Text('Add a new profile'),
          icon: const Icon(Icons.account_circle),
          content: const Text(
              'Enter any name for a new custom Profile.\nThe login will be done in Teams on the first time opening.',
              textAlign: TextAlign.center),
          actions: [
            TextField(
              decoration: const InputDecoration(
                label: Text('Account name'),
              ),
              onChanged: (val) => profileName = val,
            ),
            const SizedBox(height: 20),
            Wrap(
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                FilledButton(
                  onPressed: () {
                    final profileModel = createProfile(
                      profileName: profileName,
                      baseDirectory: teamsBaseDirectory,
                    );
                    addProfile(
                      profileModel: profileModel,
                      context: context,
                    );
                  },
                  child: const Text('Confirm'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
