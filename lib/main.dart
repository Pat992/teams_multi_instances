import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teams_multi_instances/bloc/process/process_bloc.dart';
import 'package:teams_multi_instances/bloc/profile/profile_bloc.dart';
import 'package:teams_multi_instances/views/home_screen.dart';
import 'package:teams_multi_instances/injection.dart' as injection;
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => getIt<ProfileBloc>()..add(ProfileListEvent())),
        BlocProvider(
            create: (context) => getIt<ProcessBloc>()..add(ProcessInitEvent())),
      ],
      child: MaterialApp(
        title: 'Multi Teams Instances',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
