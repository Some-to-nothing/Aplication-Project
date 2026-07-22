import 'dart:typed_data';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;


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



    await plugin.initialize(settings);



    // permission notif android 13

    await plugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();



    // exact alarm

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
        ?.createNotificationChannel(channel);



    print("NOTIF READY");

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
      "SCHEDULE : $tzTime"
    );



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



          category:
          AndroidNotificationCategory.alarm,



          fullScreenIntent:
          true,

        ),

      ),



      androidScheduleMode:
      AndroidScheduleMode.exactAllowWhileIdle,


    );



    print(
      "ALARM REGISTERED"
    );


  }






  static Future<void> testAlarm() async {


    await plugin.show(


      999,


      "TEST ALARM",


      "Notif berhasil",



      const NotificationDetails(

        android:
        AndroidNotificationDetails(

          "alarm_channel",

          "Alarm Jadwal",

          importance:
          Importance.max,

          priority:
          Priority.high,

          sound:
          RawResourceAndroidNotificationSound(
            "alarm",
          ),

        ),

      ),

    );


  }





  static Future<void> cancel(int id) async {

    await plugin.cancel(id);

  }


}