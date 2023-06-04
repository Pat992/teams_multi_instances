import 'package:flutter/material.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          'assets/images/Icon.png',
          height: 50,
        ),
        const SizedBox(width: 10),
        const Text('Multi Teams Launcher'),
      ],
    );
  }
}
