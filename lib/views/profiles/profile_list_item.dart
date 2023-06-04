import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teams_multi_instances/bloc/process/process_bloc.dart';
import 'package:teams_multi_instances/models/profile_model.dart';
import 'package:teams_multi_instances/views/utils/dialog_opener.dart';

import 'delete_profile_dialog.dart';

class ProfileListItem extends StatelessWidget {
  final ProfileModel profileModel;

  const ProfileListItem({
    Key? key,
    required this.profileModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      key: Key(profileModel.id),
      child: InkWell(
        mouseCursor: SystemMouseCursors.click,
        onTap: () => BlocProvider.of<ProcessBloc>(context, listen: false).add(
          ProcessLaunchTeamsEvent(profileModel: profileModel),
        ),
        child: ListTile(
          mouseCursor: SystemMouseCursors.click,
          leading: const Icon(Icons.account_circle),
          title: Text(profileModel.profileName),
          subtitle: profileModel.id != 'main_profile'
              ? Text('Directory: ${profileModel.profileFolder}')
              : null,
          trailing: SizedBox(
            width: 80,
            child: Row(
              children: [
                if (profileModel.id != 'main_profile')
                  IconButton(
                    icon: const Icon(Icons.folder),
                    onPressed: () =>
                        BlocProvider.of<ProcessBloc>(context, listen: false)
                            .add(
                      ProcessOpenDirectoryEvent(profileModel: profileModel),
                    ),
                  ),
                if (profileModel.id != 'main_profile')
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
