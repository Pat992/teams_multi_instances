import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teams_multi_instances/providers/profile_provider.dart';
import 'package:teams_multi_instances/views/widgets/profile_list_item.dart';

class ProfileList extends StatelessWidget {
  const ProfileList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profiles = Provider.of<ProfileProvider>(context).profiles;
    return ListView.builder(
      itemCount: profiles.length,
      itemBuilder: (context, index) =>
          ProfileListItem(profileModel: profiles[index]),
    );
  }
}
