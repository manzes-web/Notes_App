import 'package:flutter/material.dart';
import 'package:notes_app/Themes/themes.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_provider.g.dart';

@riverpod
class ThemeNotifier extends _$ThemeNotifier {
  // Initial value of the theme (light mode)
  @override
  ThemeData build() => lightMode;

  // Getter to check if dark mode is enabled
  bool get isDarkMode => state == darkMode;

  // Method to toggle between light and dark themes
  void toggleTheme() {
    state = isDarkMode ? lightMode : darkMode;
  }
}
