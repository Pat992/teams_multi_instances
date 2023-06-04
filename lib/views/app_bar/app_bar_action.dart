import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AppBarAction extends StatelessWidget {
  const AppBarAction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () async {
        final url =
            Uri.parse('https://github.com/Pat992/teams_multi_instances');
        if (await canLaunchUrl(url)) {
          print('asdasdasd');
          await launchUrl(url);
        } else {
          print('noooooooooo');
        }
      },
      icon: const Icon(Icons.open_in_new),
      label: const Text('Github'),
    );
  }
}
