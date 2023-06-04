import 'package:flutter/material.dart';
import 'package:teams_multi_instances/views/theme/settings_card.dart';

class DarkThemeSwitch extends StatelessWidget {
  final bool isDarkTheme;
  final Function switchDarkTheme;

  const DarkThemeSwitch({
    Key? key,
    required this.isDarkTheme,
    required this.switchDarkTheme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SettingsCard(
      title: 'Dark Theme',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            const Icon(Icons.brightness_4),
            const SizedBox(
              width: 10,
            ),
            Switch(
              value: isDarkTheme,
              onChanged: (val) => switchDarkTheme(val),
            ),
          ],
        ),
      ),
    );
  }
}
