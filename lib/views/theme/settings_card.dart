import 'package:flutter/material.dart';
import 'package:teams_multi_instances/views/text/sub_header.dart';

class SettingsCard extends StatelessWidget {
  final String title;
  final Widget child;

  const SettingsCard({
    Key? key,
    required this.title,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SubHeader(text: title),
            const SizedBox(height: 6),
            child,
          ],
        ),
      ),
    );
  }
}
