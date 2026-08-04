import 'package:flutter/material.dart';


// SERVICES
import 'services/notification_service.dart';
import 'services/settings_service.dart';
import 'services/battery_service.dart';
import 'services/permission_service.dart';


// PAGE
import 'pages/welcome/welcome_page.dart';


// THEME
import 'theme/app_theme.dart';


// TIMEZONE
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;


// NAVIGATOR
import 'config/app_navigator.dart';



final ValueNotifier<ThemeMode> themeNotifier =
    ValueNotifier(
      ThemeMode.system,
    );






Future<void> main() async {


  WidgetsFlutterBinding.ensureInitialized();



  // ============================
  // TIMEZONE
  // ============================

  tz.initializeTimeZones();


  tz.setLocalLocation(

    tz.getLocation(
      'Asia/Jakarta',
    ),

  );







  // ============================
  // PERMISSION ANDROID
  // ============================

  await PermissionService.requestAll();






  // ============================
  // BATTERY OPTIMIZATION
  // ============================

  await BatteryService.requestIgnoreBattery();








  // ============================
  // NOTIFICATION SERVICE
  // ============================

  await NotificationService.initialize();








  // ============================
  // LOAD THEME
  // ============================


  String mode =
      await SettingsService.getTheme();



  switch(mode){


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


    return ValueListenableBuilder<ThemeMode>(


      valueListenable:
      themeNotifier,





      builder:

          (
              context,
              mode,
              child,

          ){



        return MaterialApp(



          // navigator global

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