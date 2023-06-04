import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teams_multi_instances/bloc/process/process_bloc.dart';
import 'package:teams_multi_instances/bloc/profile/profile_bloc.dart';
import 'package:teams_multi_instances/views/widgets/add_profile_button.dart';
import 'package:teams_multi_instances/views/widgets/profile_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ProfileBloc, ProfileState>(listener: (context, state) {}),
        BlocListener<ProcessBloc, ProcessState>(listener: (context, state) {}),
      ],
      child: Scaffold(
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ProfileSuccessState) {
              return const ProfileList();
            } else {
              return const SizedBox();
            }
          },
        ),
        floatingActionButton: const AddProfileButton(),
      ),
    );
  }
}
