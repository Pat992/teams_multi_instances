import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teams_multi_instances/bloc/process/process_bloc.dart';
import 'package:teams_multi_instances/bloc/profile/profile_bloc.dart';
import 'package:teams_multi_instances/models/profile_model.dart';
import 'package:teams_multi_instances/views/profiles/profile_list_item.dart';

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
          return Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: profileModels.length,
                itemBuilder: (context, index) =>
                    ProfileListItem(profileModel: profileModels[index]),
              ),
              ElevatedButton(
                  onPressed: () {
                    for (final profileModel in profileModels) {
                      BlocProvider.of<ProcessBloc>(context).add(
                        ProcessLaunchTeamsEvent(profileModel: profileModel),
                      );
                    }
                  },
                  child: Text('Open all'))
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
