import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teams_multi_instances/bloc/process_provider.dart';
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
      child: InkWell(
        mouseCursor: SystemMouseCursors.click,
        onTap: () => Provider.of<ProcessProvider>(context, listen: false)
            .launchTeamsInstance(
          directory: profileModel.profileFolder,
        ),
        child: ListTile(
          mouseCursor: SystemMouseCursors.click,
          leading: const Icon(Icons.account_circle),
          title: Text(profileModel.profileName),
          subtitle: Text('Directory: ${profileModel.profileFolder}'),
          trailing: SizedBox(
            width: 80,
            child: Row(
              children: [
                Provider.of<ProcessProvider>(context).isLoading
                    ? const SizedBox(
                        width: 40,
                        height: 40,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : IconButton(
                        icon: const Icon(Icons.folder),
                        onPressed: () =>
                            Provider.of<ProcessProvider>(context, listen: false)
                                .openDirectory(
                          directory: profileModel.profileFolder,
                        ),
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
      ),
    );
  }
}
