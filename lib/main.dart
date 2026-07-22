import 'package:flutter/material.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'pages/home_page.dart';
import 'services/notification_service.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();


  tz.initializeTimeZones();


  await NotificationService.initialize();


  runApp(const ReminderApp());

}



class ReminderApp extends StatelessWidget {

  const ReminderApp({super.key});


  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner:false,

      title:"Sky Reminder",

      theme:ThemeData(

        colorSchemeSeed:
            Colors.lightBlue,

        useMaterial3:true,

      ),

      home:
          const HomePage(),

    );

  }

}