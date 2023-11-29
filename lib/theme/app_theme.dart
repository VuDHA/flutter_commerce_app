import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

// Class to define the theme of the application
class AppTheme {
  // Define light theme colors
  static Color lightBackgroundColor = const Color(0xfff2f2f2);
  static Color lightPrimaryColor = const Color(0xffff8900);
  static Color lightSecondaryColor = const Color(0xff040415);
  static Color lightAccentColor = Colors.blueGrey.shade200;
  static Color lightParticlesColor = const Color(0x44948282);
  static Color lightTextColor = Colors.black54;

  const AppTheme._();

  // Define the light theme
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: lightPrimaryColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    appBarTheme: AppBarTheme(backgroundColor: lightPrimaryColor),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: lightBackgroundColor),
    ),
    colorScheme: ColorScheme.light(
      secondary: lightSecondaryColor,
    ).copyWith(background: lightBackgroundColor),
  );

  // Get the current system brightness
  static Brightness get currentSystemBrightness =>
      SchedulerBinding.instance.window.platformBrightness;

  // Set status bar and navigation bar colors based on the theme mode
  static setStatusBarAndNavigationBarColors(ThemeMode themeMode) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.light,
      systemNavigationBarColor: lightBackgroundColor,
      systemNavigationBarDividerColor: Colors.transparent,
    ));
  }
}
