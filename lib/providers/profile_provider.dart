import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teams_multi_instances/models/profile_model.dart';

abstract class IProfileProvider with ChangeNotifier {
  Future<void> init();

  Future<void> addProfile({required ProfileModel profileModel});

  Future<void> removeProfile({required ProfileModel profileModel});

  Future<void> writeProfiles({required List<String> profileStringList});

  List<String> toList();
}

class ProfileProvider with ChangeNotifier implements IProfileProvider {
  bool isLoading = false;
  String errorMessage = '';
  final String key = 'teams_profiles';
  late final SharedPreferences sharedPreferences;
  final List<ProfileModel> profiles = [];

  @override
  Future<void> init() async {
    try {
      errorMessage = '';
      isLoading = true;
      notifyListeners();

      sharedPreferences = await SharedPreferences.getInstance();
      final profilesFromShPr = sharedPreferences.getStringList(key);
      final profilesFuture = await Future.value(profilesFromShPr ?? []);

      for (final profile in profilesFuture) {
        profiles.add(
          ProfileModel.fromJson(
            json: jsonDecode(profile),
          ),
        );
      }
    } catch (e) {
      errorMessage = 'Error getting saved profiles';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  @override
  Future<void> addProfile({required ProfileModel profileModel}) async {
    try {
      errorMessage = '';
      isLoading = true;
      notifyListeners();

      profiles.add(profileModel);
      final profileStringList = toList();
      await writeProfiles(profileStringList: profileStringList);
    } catch (e) {
      errorMessage = 'Error saving profile';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  @override
  Future<void> removeProfile({required ProfileModel profileModel}) async {
    try {
      errorMessage = '';
      isLoading = true;
      notifyListeners();

      profiles.remove(profileModel);
      final profileStringList = toList();
      await writeProfiles(profileStringList: profileStringList);
    } catch (e) {
      errorMessage = 'Error deleting profile';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  @override
  Future<void> writeProfiles({required List<String> profileStringList}) async {
    final res = await sharedPreferences.setStringList(key, profileStringList);

    if (!res) {
      throw Exception();
    }
  }

  @override
  List<String> toList() {
    final List<String> profileStringList = [];
    for (final profile in profiles) {
      profileStringList.add(
        json.encode(
          profile.toJson(),
        ),
      );
    }
    return profileStringList;
  }
}
