import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teams_multi_instances/bloc/process/process_bloc.dart';
import 'package:teams_multi_instances/bloc/profile/profile_bloc.dart';
import 'package:teams_multi_instances/views/app_bar/app_bar_action.dart';
import 'package:teams_multi_instances/views/app_bar/app_bar_title.dart';
import 'package:teams_multi_instances/views/theme/theme_settings.dart';
import 'package:teams_multi_instances/views/utils/error_snack_bar.dart';
import 'package:teams_multi_instances/views/profiles/add_profile_button.dart';
import 'package:teams_multi_instances/views/profiles/profile_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ProfileBloc, ProfileState>(listener: (context, state) {
          if (state is ProfileFailureState) {
            ErrorSnackBar.openSnackBar(
              context: context,
              title: state.failureModel.title,
              description: state.failureModel.description,
            );
          }
        }),
        BlocListener<ProcessBloc, ProcessState>(listener: (context, state) {
          if (state is ProcessFailureState) {
            ErrorSnackBar.openSnackBar(
              context: context,
              title: state.failureModel.title,
              description: state.failureModel.description,
            );
          }
        }),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const AppBarTitle(),
          actions: const [
            AppBarAction(),
            SizedBox(width: 5),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Flexible(
                flex: 1,
                child: ThemeSettings(),
              ),
              const VerticalDivider(),
              BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  if (state is ProfileLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is ProfileSuccessState) {
                    return const Flexible(
                      fit: FlexFit.loose,
                      flex: 2,
                      child: ProfileList(),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ],
          ),
        ),
        floatingActionButton: const AddProfileButton(),
      ),
    );
  }
}
