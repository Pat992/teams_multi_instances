import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teams_multi_instances/bloc/theme/theme_bloc.dart';
import 'package:teams_multi_instances/models/theme_model.dart';
import 'package:teams_multi_instances/utils/theme_util.dart';
import 'package:teams_multi_instances/views/text/header.dart';
import 'package:teams_multi_instances/views/theme/settings_card.dart';

import 'color_picker_button.dart';
import 'dark_theme_switch.dart';

class ThemeSettings extends StatelessWidget {
  final colorMap = ThemeUtil.colorMap;

  const ThemeSettings({Key? key}) : super(key: key);

  void updateTheme({
    required bool isDarkTheme,
    required Color updateColor,
    required BuildContext context,
  }) {
    final themeModel = ThemeModel(
      isDarkTheme: isDarkTheme,
      color: updateColor,
    );
    BlocProvider.of<ThemeBloc>(context, listen: false)
        .add(ThemeUpdateEvent(themeModel: themeModel));
  }

  @override
  Widget build(BuildContext context) {
    final colorValues = colorMap.values.toList();
    bool isDarkTheme = false;
    Color seedColor = Colors.deepPurple;

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        if (state is ThemeSuccessState) {
          seedColor = state.themeModel.color;
          isDarkTheme = state.themeModel.isDarkTheme;
        }

        return ListView(
          children: [
            const Center(child: Header(text: 'Theme Settings')),
            const SizedBox(height: 16),
            Column(
              children: [
                DarkThemeSwitch(
                  isDarkTheme: isDarkTheme,
                  switchDarkTheme: (val) => updateTheme(
                      isDarkTheme: val,
                      updateColor: seedColor,
                      context: context),
                ),
                SettingsCard(
                  title: 'Colors',
                  child: Theme(
                    data: Theme.of(context)
                        .copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      title: const Text('Colors'),
                      children: [
                        const SizedBox(height: 10),
                        GridView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 50,
                            childAspectRatio: 1 / 1,
                            crossAxisSpacing: 1,
                            mainAxisSpacing: 1,
                          ),
                          itemCount: colorMap.length,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: ColorPickerButton(
                              buttonColor: colorValues[index],
                              seedColor: seedColor,
                              updateColorSeed: () => updateTheme(
                                  isDarkTheme: isDarkTheme,
                                  updateColor: colorValues[index],
                                  context: context),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
