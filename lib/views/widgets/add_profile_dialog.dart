import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teams_multi_instances/models/profile_model.dart';
import 'package:teams_multi_instances/providers/profile_provider.dart';
import 'package:teams_multi_instances/views/utils/error_snack_bar.dart';

class AddProfileDialog extends StatelessWidget {
  const AddProfileDialog({Key? key}) : super(key: key);

  void addProfile(
      {required String profileName, required BuildContext context}) {
    if (profileName.isEmpty) {
      ErrorSnackBar.openSnackBar(
        context: context,
        title: 'Empty profile name',
        description: 'The profile name needs to be set.',
      );
    } else {
      String id = profileName.replaceAll(RegExp('[^A-Za-z0-9]'), '');
      final profileModel = ProfileModel(
        id: id,
        profileName: profileName,
        profileFolder: id,
      );
      Provider.of<ProfileProvider>(context, listen: false)
          .addProfile(profileModel: profileModel);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    String profileName = '';

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
                addProfile(profileName: profileName, context: context);
              },
              child: const Text('Confirm'),
            ),
          ],
        ),
      ],
    );
  }
}
