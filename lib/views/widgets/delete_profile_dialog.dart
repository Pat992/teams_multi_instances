import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teams_multi_instances/models/profile_model.dart';
import 'package:teams_multi_instances/providers/process_provider.dart';
import 'package:teams_multi_instances/providers/profile_provider.dart';

class DeleteProfileDialog extends StatelessWidget {
  final ProfileModel profileModel;

  const DeleteProfileDialog({Key? key, required this.profileModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
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
            Provider.of<ProcessProvider>(context, listen: false)
                .removeDirectory(directory: profileModel.profileFolder);
            Provider.of<ProfileProvider>(context, listen: false)
                .removeProfile(profileModel: profileModel);
            Navigator.of(context).pop();
          },
          child: const Text('Confirm'),
        ),
      ],
    );
  }
}
