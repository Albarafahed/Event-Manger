import 'package:flutter/material.dart';

class ThemeController {
  // ===== Dark Mode =====
  static ValueNotifier<ThemeMode> themeMode = ValueNotifier<ThemeMode>(
    ThemeMode.light,
  );

  // ===== Primary Color =====
  static ValueNotifier<Color> primaryColor = ValueNotifier<Color>(
    Colors.deepPurple,
  );

  // ===== Font Size =====
  static ValueNotifier<double> fontSize = ValueNotifier<double>(16);

  // ===== Notifications Enabled =====
  static ValueNotifier<bool> notificationsEnabled = ValueNotifier<bool>(true);

  // ===== Toggle Dark Mode =====
  static void toggleDarkMode() {
    themeMode.value = themeMode.value == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
  }

  // ===== Set Primary Color =====
  static void setPrimaryColor(Color color) {
    primaryColor.value = color;
  }

  // ===== Set Font Size =====
  static void setFontSize(double size) {
    fontSize.value = size;
  }

  // ===== Toggle Notifications =====
  static void toggleNotifications() {
    notificationsEnabled.value = !notificationsEnabled.value;
  }
}
