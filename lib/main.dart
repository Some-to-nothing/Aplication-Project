import 'package:flutter/material.dart';

import 'services/notification_service.dart';
import 'pages/home_page.dart';

import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;



void main() async {


  WidgetsFlutterBinding.ensureInitialized();



  // Initialize timezone

  tz.initializeTimeZones();



  // Set zona waktu Indonesia

  tz.setLocalLocation(
    tz.getLocation(
      'Asia/Jakarta',
    ),
  );



  await NotificationService.initialize();



  runApp(
    const MyApp(),
  );

}







class MyApp extends StatelessWidget {


  const MyApp({
    super.key,
  });



  @override
  Widget build(BuildContext context){


    return MaterialApp(


      debugShowCheckedModeBanner:false,


      title:
      "Jadwalese",



      theme:

      ThemeData(

        primarySwatch:
        Colors.blue,

      ),



      home:

      const HomePage(),



    );


  }


}