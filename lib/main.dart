import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teams_multi_instances/bloc/process/process_bloc.dart';
import 'package:teams_multi_instances/bloc/profile/profile_bloc.dart';
import 'package:teams_multi_instances/views/home_screen.dart';
import 'package:teams_multi_instances/injection.dart' as injection;
import 'bloc/theme/theme_bloc.dart';
import 'injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await injection.init();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDarkTheme = false;
    Color seedColor = Colors.deepPurple;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
            getIt<ThemeBloc>()
              ..add(ThemeInitEvent())),
        BlocProvider(
            create: (context) =>
            getIt<ProfileBloc>()
              ..add(ProfileListEvent())),
        BlocProvider(
            create: (context) =>
            getIt<ProcessBloc>()
              ..add(ProcessInitEvent())),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          if (state is ThemeSuccessState) {
            isDarkTheme = state.themeModel.isDarkTheme;
            seedColor = state.themeModel.color;
          }
          return MaterialApp(
            title: 'Multi Teams Instances',
            theme: ThemeData(
              bottomNavigationBarTheme: isDarkTheme && seedColor != Colors.black
                  ? BottomNavigationBarThemeData(
                selectedItemColor: seedColor,
              )
                  : null,
              colorScheme: ColorScheme.fromSeed(
                seedColor: seedColor,
                brightness:
                isDarkTheme == true ? Brightness.dark : Brightness.light,
              ),
              useMaterial3: true,
            ),
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}
