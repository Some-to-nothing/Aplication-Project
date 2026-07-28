import 'package:flutter/material.dart';

import 'services/notification_service.dart';
import 'services/storage_service.dart';
import 'services/settings_service.dart';

import 'pages/home/home_page.dart';
import 'pages/onboarding/onboarding_page.dart';

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

class StartPage extends StatelessWidget {

  const StartPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(

      future:
      StorageService.isOnboardingDone(),

      builder:
          (context, snapshot) {

        if (!snapshot.hasData) {

          return const Scaffold(

            body:
            Center(

              child:
              CircularProgressIndicator(),

            ),

          );

        }

        if (snapshot.data == true) {

          return const HomePage();

        }

        return const OnboardingPage();

      },

    );

  }

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
  "PROKELOM V3",

  theme:
  AppTheme.lightTheme,

  darkTheme:
  AppTheme.darkTheme,

  themeMode:
  mode,

  home:
  const StartPage(),

);

      },

    );

  }

}