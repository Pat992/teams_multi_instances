part of 'theme_bloc.dart';

abstract class ThemeState extends Equatable {
  const ThemeState();
}

class ThemeInitial extends ThemeState {
  @override
  List<Object> get props => [];
}

class ThemeLoadingState extends ThemeState {
  @override
  List<Object> get props => [];
}

class ThemeSuccessState extends ThemeState {
  final ThemeModel themeModel;

  const ThemeSuccessState({required this.themeModel});

  @override
  List<Object> get props => [themeModel];
}

class ThemeFailureState extends ThemeState {
  final FailureModel failure;

  const ThemeFailureState({required this.failure});

  @override
  List<Object> get props => [failure];
}
