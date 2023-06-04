import 'dart:ui';

import 'package:teams_multi_instances/utils/theme_util.dart';

class ThemeModel {
  final String id;
  final bool isDarkTheme;
  final Color color;
  final items = ThemeUtil.colorMap;

  const ThemeModel({
    this.id = 'theme',
    required this.isDarkTheme,
    required this.color,
  });

  factory ThemeModel.fromJson({required Map<String, dynamic> json}) =>
      ThemeModel(
        id: json['id'],
        isDarkTheme: json['isDarkTheme'],
        color: ThemeUtil.colorMap[json['color']]!,
      );

  toJson() => {
        'id': id,
        'isDarkTheme': isDarkTheme,
        'color': items.keys.firstWhere((element) => items[element] == color),
      };
}
