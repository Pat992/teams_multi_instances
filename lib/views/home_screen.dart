import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teams_multi_instances/bloc/profile_provider.dart';
import 'package:teams_multi_instances/views/utils/dialog_opener.dart';
import 'package:teams_multi_instances/views/widgets/profile_list.dart';
import 'package:teams_multi_instances/views/widgets/add_profile_dialog.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Provider.of<ProfileProvider>(context).isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : const ProfileList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => DialogOpener.openDialog(
          context: context,
          dialog: const AddProfileDialog(),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
