import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teams_multi_instances/views/home_screen.dart';

import 'bloc/process_provider.dart';
import 'bloc/profile_provider.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProfileProvider()..init()),
        ChangeNotifierProvider(create: (context) => ProcessProvider()..init()),
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
