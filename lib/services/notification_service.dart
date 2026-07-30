import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

import 'debug_service.dart';

import '../config/app_navigator.dart';
import '../pages/alarm/alarm_screen.dart';



class NotificationService {


  static final FlutterLocalNotificationsPlugin plugin =
      FlutterLocalNotificationsPlugin();



  // CHANNEL BARU
  // Android menyimpan channel lama.
  // Ganti ID supaya membuat channel baru.
  static const String channelId =
      "remindus_alarm_channel_v2";






  static Future<void> initialize() async {


    try {


      const androidInit =
      AndroidInitializationSettings(
        '@mipmap/ic_launcher',
      );



      const settings =
      InitializationSettings(
        android: androidInit,
      );





      await plugin.initialize(


        settings,


        onDidReceiveNotificationResponse:

        (response) async {



          await DebugService.log(

            "NOTIFICATION CLICK : ${response.payload}",

          );



          if(response.payload == null){

            return;

          }




          final data =

          jsonDecode(

            response.payload!,

          );





          navigatorKey.currentState?.push(


            MaterialPageRoute(


              builder: (_) => AlarmScreen(


                eventId:

                data["eventId"],



                notificationId:

                data["notificationId"],



                title:

                data["title"],



                body:

                data["body"],



              ),

            ),


          );



        },


      );







      await plugin

          .resolvePlatformSpecificImplementation<

          AndroidFlutterLocalNotificationsPlugin>()

          ?.requestNotificationsPermission();





      await DebugService.log(

        "NOTIFICATION PERMISSION DONE",

      );







      await plugin

          .resolvePlatformSpecificImplementation<

          AndroidFlutterLocalNotificationsPlugin>()

          ?.requestExactAlarmsPermission();





      await DebugService.log(

        "EXACT ALARM PERMISSION DONE",

      );









      const channel =

      AndroidNotificationChannel(


        channelId,


        "RemindUs Alarm",


        description:

        "Personal reminder alarm",



        importance:

        Importance.max,



        playSound:

        true,



        enableVibration:

        true,



      );








      await plugin

          .resolvePlatformSpecificImplementation<

          AndroidFlutterLocalNotificationsPlugin>()

          ?.createNotificationChannel(

        channel,

      );






      await DebugService.log(

        "CHANNEL CREATED : $channelId",

      );




      await DebugService.log(

        "INITIALIZE SUCCESS",

      );



    }


    catch(e){


      await DebugService.log(

        "INITIALIZE ERROR : $e",

      );


    }


  }













  static Future<void> schedule({


    required int id,


    required int eventId,


    required String title,


    required String body,


    required DateTime time,


  }) async {



    try {



      final tzTime =


      tz.TZDateTime.from(


        time,


        tz.local,


      );








      final payload =


      jsonEncode({


        "eventId":

        eventId,


        "notificationId":

        id,


        "title":

        title,


        "body":

        body,

      });









      await plugin.zonedSchedule(


        id,


        title,


        body,


        tzTime,



        const NotificationDetails(



          android:

          AndroidNotificationDetails(



            channelId,



            "RemindUs Alarm",



            channelDescription:

            "Personal reminder alarm",



            importance:

            Importance.max,



            priority:

            Priority.high,



            category:

            AndroidNotificationCategory.alarm,



            playSound:

            true,



            enableVibration:

            true,



            fullScreenIntent:

            true,



            autoCancel:

            false,



          ),


        ),




        payload:

        payload,





        androidScheduleMode:

        AndroidScheduleMode.exactAllowWhileIdle,


      );







      await DebugService.log(

        "ALARM REGISTERED : $title",

      );



    }



    catch(e){



      await DebugService.log(

        "SCHEDULE ERROR : $e",

      );



    }


  }














  static Future<void> testAlarm() async {



    try {



      final payload =


      jsonEncode({


        "eventId":

        999,


        "notificationId":

        999,


        "title":

        "RemindUs Test Alarm",


        "body":

        "Ini adalah percobaan alarm",

      });







      await plugin.show(



        999,



        "RemindUs Test Alarm",



        "Ini adalah percobaan alarm",




        const NotificationDetails(



          android:

          AndroidNotificationDetails(



            channelId,



            "RemindUs Alarm",



            channelDescription:

            "Personal reminder alarm",




            importance:

            Importance.max,



            priority:

            Priority.high,



            category:

            AndroidNotificationCategory.alarm,



            playSound:

            true,



            enableVibration:

            true,



            fullScreenIntent:

            true,



            autoCancel:

            false,



          ),


        ),





        payload:

        payload,



      );







      await DebugService.log(

        "TEST ALARM SENT TO PHONE",

      );



    }



    catch(e){


      await DebugService.log(

        "TEST ALARM ERROR : $e",

      );


    }



  }













  static Future<void> cancel(

      int id

      ) async {



    await plugin.cancel(

      id,

    );



    await DebugService.log(

      "CANCEL : $id",

    );



  }



}