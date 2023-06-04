import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AppBarAction extends StatelessWidget {
  const AppBarAction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      waitDuration: const Duration(seconds: 1),
      message: 'Go to Github repository',
      child: TextButton.icon(
        onPressed: () async {
          final url =
              Uri.parse('https://github.com/Pat992/teams_multi_instances');
          if (await canLaunchUrl(url)) {
            await launchUrl(url);
          }
        },
        icon: const Icon(Icons.open_in_new),
        label: const Text('Github'),
      ),
    );
  }
}
