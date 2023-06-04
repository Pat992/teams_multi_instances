part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
}

class ThemeInitEvent extends ThemeEvent {
  @override
  List<Object?> get props => [];
}

class ThemeUpdateEvent extends ThemeEvent {
  final ThemeModel themeModel;

  const ThemeUpdateEvent({required this.themeModel});

  @override
  List<Object?> get props => [themeModel];
}
