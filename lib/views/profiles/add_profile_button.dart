import 'package:flutter/material.dart';
import 'package:teams_multi_instances/views/utils/dialog_opener.dart';

import 'add_profile_dialog.dart';

class AddProfileButton extends StatelessWidget {
  const AddProfileButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => DialogOpener.openDialog(
        context: context,
        dialog: const AddProfileDialog(),
      ),
      child: const Icon(Icons.add),
    );
  }
}
