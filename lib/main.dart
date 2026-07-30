import 'package:flutter/material.dart';

import 'services/notification_service.dart';
import 'services/settings_service.dart';


import 'pages/welcome/welcome_page.dart';

import 'theme/app_theme.dart';

import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'config/app_navigator.dart';

final ValueNotifier<ThemeMode> themeNotifier =
    ValueNotifier(ThemeMode.system);

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  tz.initializeTimeZones();

  tz.setLocalLocation(
    tz.getLocation(
      'Asia/Jakarta',
    ),
  );

  await NotificationService.initialize();

  String mode =
      await SettingsService.getTheme();

  switch (mode) {

    case "light":
      themeNotifier.value =
          ThemeMode.light;
      break;

    case "dark":
      themeNotifier.value =
          ThemeMode.dark;
      break;

    default:
      themeNotifier.value =
          ThemeMode.system;
  }
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {

  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(

      valueListenable:
      themeNotifier,

      builder:
          (context, mode, child) {

        return MaterialApp(

  navigatorKey:
  navigatorKey,

  debugShowCheckedModeBanner:
  false,

  title:
  "RemindUs",

  theme:
  AppTheme.lightTheme,

  darkTheme:
  AppTheme.darkTheme,

  themeMode:
  mode,

  home:
  const WelcomePage(),

);

      },

    );

  }

}