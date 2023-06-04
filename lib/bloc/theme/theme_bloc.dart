import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teams_multi_instances/models/failure_model.dart';
import 'package:teams_multi_instances/models/theme_model.dart';
import 'package:teams_multi_instances/utils/theme_util.dart';

part 'theme_event.dart';

part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  late ThemeModel themeModel;
  final SharedPreferences sharedPreferences;
  final key = 'teams_profiles_themes';

  ThemeBloc({required this.sharedPreferences}) : super(ThemeInitial()) {
    on<ThemeInitEvent>((event, emit) async {
      try {
        emit(ThemeLoadingState());

        themeModel = ThemeModel(
          isDarkTheme: false,
          color: ThemeUtil.colorMap['deepPurple']!,
        );
        final themeFromShPr = sharedPreferences.getString(key);
        final themeFutureString = await Future.value(themeFromShPr ?? '');

        if (themeFutureString.isNotEmpty) {
          themeModel =
              ThemeModel.fromJson(json: json.decode(themeFutureString));
        }

        emit(ThemeSuccessState(themeModel: themeModel));
      } catch (e) {
        emit(
          ThemeFailureState(
            failure: FailureModel(
                title: 'Error loading theme', description: e.toString()),
          ),
        );
      }
    });

    on<ThemeUpdateEvent>((event, emit) async {
      try {
        emit(ThemeLoadingState());

        themeModel = event.themeModel;
        final res = await sharedPreferences.setString(
            key, json.encode(event.themeModel.toJson()));

        if (!res) {
          throw Exception('Error saving theme update to shared preferences.');
        }

        emit(ThemeSuccessState(themeModel: themeModel));
      } catch (e) {
        emit(
          ThemeFailureState(
            failure: FailureModel(
                title: 'Error updating theme', description: e.toString()),
          ),
        );
      }
    });
  }
}
