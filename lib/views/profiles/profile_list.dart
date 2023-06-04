import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teams_multi_instances/bloc/profile/profile_bloc.dart';
import 'package:teams_multi_instances/models/profile_model.dart';
import 'package:teams_multi_instances/views/profiles/open_all_button.dart';
import 'package:teams_multi_instances/views/profiles/profile_list_item.dart';
import 'package:teams_multi_instances/views/text/header.dart';

class ProfileList extends StatelessWidget {
  const ProfileList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileSuccessState) {
          final profileModels = [
            ProfileModel(
              id: 'main_profile',
              profileName: 'Main Profile',
              profileFolder: '',
            ),
          ];

          profileModels.addAll(state.profileModels);
          return Stack(
            fit: StackFit.loose,
            children: [
              ListView(
                children: [
                  const Center(child: Header(text: 'Teams Profiles')),
                  const SizedBox(height: 16),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: profileModels.length,
                    itemBuilder: (context, index) =>
                        ProfileListItem(profileModel: profileModels[index]),
                  ),
                ],
              ),
              OpenAllButton(profileModels: profileModels),
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
