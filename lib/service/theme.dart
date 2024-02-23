import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChoikakiTheme {
  final Color primaryColor;
  final Background background;

  ChoikakiTheme({required this.primaryColor, required this.background});

  ChoikakiTheme copyWith({
    Color? primaryColor,
    Background? background,
  }) {
    return ChoikakiTheme(
      primaryColor: primaryColor ?? this.primaryColor,
      background: background ?? this.background,
    );
  }
}

class Background {
  Color color;
  String? image;

  Background({required this.color, this.image});
}

final defaultTheme = ChoikakiTheme(
  primaryColor: const Color(0xFFE49BFC),
  background: Background(color: const Color(0xFFFFFFFF)),
);

void setTheme(ChoikakiTheme theme) async {
  final prefs = await SharedPreferences.getInstance();

  await prefs.setInt('primaryColor', theme.primaryColor.value);
  await prefs.setInt('backgroundColor', theme.background.color.value);
  await prefs.setString('backgroundImage', theme.background.image ?? '');
}

Future<ChoikakiTheme> getTheme() async {
  final prefs = await SharedPreferences.getInstance();

  final primaryColor =
      prefs.getInt('primaryColor') ?? defaultTheme.primaryColor.value;
  final backgroundColor =
      prefs.getInt('backgroundColor') ?? defaultTheme.background.color.value;
  final backgroundImage =
      prefs.getString('backgroundImage') ?? defaultTheme.background.image;

  return ChoikakiTheme(
    primaryColor: Color(primaryColor),
    background:
        Background(color: Color(backgroundColor), image: backgroundImage),
  );
}
