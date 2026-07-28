import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

import '../config/app_navigator.dart';
import '../pages/alarm/alarm_screen.dart';





class NotificationService {



  static final FlutterLocalNotificationsPlugin plugin =
  FlutterLocalNotificationsPlugin();





  static Future<void> initialize() async {



    const android =
    AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );



    const settings =
    InitializationSettings(
      android: android,
    );





    await plugin.initialize(


      settings,


      onDidReceiveNotificationResponse:
          (response){



        if(response.payload == null){
          return;
        }




        final data =
        jsonDecode(
          response.payload!,
        );



        navigatorKey.currentState?.push(


          MaterialPageRoute(


            builder: (_)=>

            AlarmScreen(


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





    await plugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.requestExactAlarmsPermission();






    const channel =
    AndroidNotificationChannel(


      "alarm_channel",


      "Alarm Jadwal",


      description:
      "Alarm kegiatan",


      importance:
      Importance.max,


      playSound:
      true,


      enableVibration:
      true,


      sound:
      RawResourceAndroidNotificationSound(
        "alarm",
      ),


    );





    await plugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(
      channel,
    );



    print(
      "NOTIFICATION READY",
    );


  }









  static Future<void> schedule({


    required int id,


    required String title,


    required String body,


    required DateTime time,



  }) async {




    final tzTime =
    tz.TZDateTime.from(
      time,
      tz.local,
    );

    print(
  """
===== SCHEDULE DEBUG =====
ID       : $id
TITLE    : $title
TIME     : $tzTime
NOW      : ${tz.TZDateTime.now(tz.local)}
==========================
"""
);





    final payload =
    jsonEncode({


      "eventId":
      id,


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



      NotificationDetails(


        android:


        AndroidNotificationDetails(



          "alarm_channel",



          "Alarm Jadwal",



          channelDescription:
          "Alarm kegiatan",



          importance:
          Importance.max,



          priority:
          Priority.high,



          category:
          AndroidNotificationCategory.alarm,



          playSound:
          true,



          sound:
          const RawResourceAndroidNotificationSound(
            "alarm",
          ),



          enableVibration:
          true,



          vibrationPattern:
          Int64List.fromList(

            [

              0,

              1000,

              500,

              1000,

            ],

          ),



          fullScreenIntent:
          true,



        ),


      ),




      payload:
      payload,





      androidScheduleMode:

      AndroidScheduleMode.exactAllowWhileIdle,



    );




    print(
      "ALARM REGISTERED : $title",
    );


  }









  static Future<void> testAlarm() async {



    final payload =
    jsonEncode({


      "eventId":
      999,


      "notificationId":
      999,


      "title":
      "TEST ALARM",


      "body":
      "Tes notification",


    });






    await plugin.show(



      999,



      "TEST ALARM",



      "Tes notification",





      const NotificationDetails(



        android:

        AndroidNotificationDetails(



          "alarm_channel",



          "Alarm Jadwal",



          importance:
          Importance.max,



          priority:
          Priority.high,



          category:
          AndroidNotificationCategory.alarm,



          fullScreenIntent:
          true,



          sound:
          RawResourceAndroidNotificationSound(
            "alarm",
          ),



        ),


      ),




      payload:
      payload,



    );



  }









  static Future<void> cancel(
      int id
      ) async {


    await plugin.cancel(
      id,
    );


  }




}