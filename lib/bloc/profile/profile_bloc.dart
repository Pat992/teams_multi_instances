import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teams_multi_instances/models/failure_model.dart';
import 'package:teams_multi_instances/models/profile_model.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final SharedPreferences sharedPreferences;
  final key = 'teams_profiles';
  List<ProfileModel> profileModels = [];

  List<String> toList({required List<ProfileModel> profileModels}) {
    final List<String> profileStringList = [];
    for (final profile in profileModels) {
      profileStringList.add(
        json.encode(
          profile.toJson(),
        ),
      );
    }
    return profileStringList;
  }

  Future<void> writeProfiles({required List<String> profileStringList}) async {
    final res = await sharedPreferences.setStringList(key, profileStringList);

    if (!res) {
      throw Exception();
    }
  }

  ProfileBloc({required this.sharedPreferences}) : super(ProfileInitial()) {
    on<ProfileListEvent>((event, emit) async {
      try {
        emit(ProfileLoadingState());
        final profilesFromShPr = sharedPreferences.getStringList(key);
        final profilesFuture = await Future.value(profilesFromShPr ?? []);

        for (final profile in profilesFuture) {
          profileModels.add(
            ProfileModel.fromJson(
              json: jsonDecode(profile),
            ),
          );
        }

        emit(ProfileSuccessState(profileModels: profileModels));
      } catch (e) {
        emit(
          ProfileFailureState(
            failureModel: FailureModel(
              title: 'Error getting saved profiles',
              description: e.toString(),
            ),
          ),
        );
      }
    });

    on<ProfileAddEvent>((event, emit) async {
      try {
        emit(ProfileLoadingState());

        final profileFromExisting = profileModels.firstWhere(
            (element) => element.id == event.profileModel.id,
            orElse: () =>
                ProfileModel(id: '', profileName: '', profileFolder: ''));

        if (event.profileModel.profileName.isEmpty) {
          emit(
            const ProfileFailureState(
              failureModel: FailureModel(
                title: 'Empty profile name',
                description: 'The profile name needs to be set.',
              ),
            ),
          );
          return;
        } else if (profileFromExisting.id.isNotEmpty) {
          ProfileFailureState(
            failureModel: FailureModel(
              title: 'Profile id ${event.profileModel.id} existing',
              description:
                  'The profile name needs to be unique after removing special characters and spaces to create a new folder.',
            ),
          );
          return;
        }

        profileModels.add(event.profileModel);
        final profileStringList = toList(profileModels: profileModels);
        await writeProfiles(profileStringList: profileStringList);
        emit(ProfileSuccessState(profileModels: profileModels));
      } catch (e) {
        emit(
          ProfileFailureState(
            failureModel: FailureModel(
              title: 'Error saving profile',
              description: e.toString(),
            ),
          ),
        );
      }
    });

    on<ProfileRemoveEvent>((event, emit) async {
      try {
        emit(ProfileLoadingState());

        profileModels.remove(event.profileModel);
        final profileStringList = toList(profileModels: profileModels);
        await writeProfiles(profileStringList: profileStringList);
        emit(ProfileSuccessState(profileModels: profileModels));
      } catch (e) {
        emit(
          ProfileFailureState(
            failureModel: FailureModel(
              title: 'Error deleting profile',
              description: e.toString(),
            ),
          ),
        );
      }
    });
  }
}
