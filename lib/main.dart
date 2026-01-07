import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/sign_up_screen.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/chat_screen.dart';
import 'theme_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // استخدام ValueNotifier للتغيير الديناميكي للثيمات والألوان
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeController.themeMode,
      builder: (context, themeMode, _) {
        return ValueListenableBuilder<Color>(
          valueListenable: ThemeController.primaryColor,
          builder: (context, color, _) {
            return ValueListenableBuilder<double>(
              valueListenable: ThemeController.fontSize,
              builder: (context, fontSize, _) {
                return MaterialApp(
                  title: 'Event Manager',
                  debugShowCheckedModeBanner: false,
                  themeMode: themeMode,
                  theme: ThemeData(
                    primarySwatch: createMaterialColor(color),
                    scaffoldBackgroundColor: Colors.deepPurple[50],
                    appBarTheme: AppBarTheme(
                      backgroundColor: color,
                      centerTitle: true,
                      elevation: 2,
                      titleTextStyle: TextStyle(
                        fontSize: 20 * (fontSize / 16),
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    elevatedButtonTheme: ElevatedButtonThemeData(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: color,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        textStyle: TextStyle(
                          fontSize: 18 * (fontSize / 16),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    inputDecorationTheme: InputDecorationTheme(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: color, width: 2),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                    ),
                    textButtonTheme: TextButtonThemeData(
                      style: TextButton.styleFrom(
                        foregroundColor: color,
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16 * (fontSize / 16),
                        ),
                      ),
                    ),
                    useMaterial3: true,
                  ),
                  darkTheme: ThemeData(
                    brightness: Brightness.dark,
                    primaryColor: color,
                    scaffoldBackgroundColor: Colors.grey[900],
                    appBarTheme: AppBarTheme(
                      backgroundColor: color,
                      centerTitle: true,
                      elevation: 2,
                      titleTextStyle: TextStyle(
                        fontSize: 20 * (fontSize / 16),
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  home: const SplashScreen(),
                  routes: {
                    '/login': (context) => LoginScreen(),
                    '/sign-up': (context) => SignUpScreen(),
                    '/home': (context) => const HomeScreen(),
                    '/chat': (context) => const SmartChatScreen(),
                    '/settings': (context) => const SettingsScreen(),
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}

// تحويل أي Color إلى MaterialColor
MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  // ignore: deprecated_member_use
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }

  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  // ignore: deprecated_member_use
  return MaterialColor(color.value, swatch);
}
