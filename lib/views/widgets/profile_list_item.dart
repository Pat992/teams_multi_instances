import 'package:flutter/material.dart';
import 'package:teams_multi_instances/models/profile_model.dart';
import 'package:teams_multi_instances/views/utils/dialog_opener.dart';
import 'package:teams_multi_instances/views/widgets/delete_profile_dialog.dart';

class ProfileListItem extends StatelessWidget {
  final ProfileModel profileModel;

  const ProfileListItem({
    Key? key,
    required this.profileModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      key: Key(profileModel.id),
      child: ListTile(
        leading: const Icon(Icons.account_circle),
        title: Text(profileModel.profileName),
        subtitle: Text('Directory: ${profileModel.profileFolder}'),
        trailing: SizedBox(
          width: 80,
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.folder),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: () => DialogOpener.openDialog(
                  dialog: DeleteProfileDialog(profileModel: profileModel),
                  context: context,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
