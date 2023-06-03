import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teams_multi_instances/bloc/profile/profile_bloc.dart';
import 'package:teams_multi_instances/views/widgets/profile_list_item.dart';

class ProfileList extends StatelessWidget {
  const ProfileList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileSuccessState) {
          return ListView.builder(
            itemCount: state.profileModels.length,
            itemBuilder: (context, index) =>
                ProfileListItem(profileModel: state.profileModels[index]),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
