import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;



class NotificationService {


  static final FlutterLocalNotificationsPlugin plugin =
      FlutterLocalNotificationsPlugin();





  static Future<void> initialize() async {


    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings(
          '@mipmap/ic_launcher',
        );



    const InitializationSettings settings =
        InitializationSettings(

      android: androidSettings,

    );



    await plugin.initialize(settings);





    // Permission notifikasi Android 13+

    await plugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();





    // Permission exact alarm

    await plugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.requestExactAlarmsPermission();







    // Notification channel

    const AndroidNotificationChannel channel =
        AndroidNotificationChannel(

      'alarm_channel_v2',

      'Alarm Reminder',


      description:
          'Notifikasi pengingat alarm',



      importance:
          Importance.max,



      playSound:
          true,



      sound:
          RawResourceAndroidNotificationSound(
            'alarm',
          ),



      enableVibration:
          true,

    );






    await plugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);



  }









  static Future<void> scheduleNotification({


    required int id,


    required String title,


    required String body,


    required DateTime time,


  }) async {





    await plugin.zonedSchedule(


      id,


      title,


      body,



      tz.TZDateTime.from(

        time,

        tz.local,

      ),





      const NotificationDetails(



        android:
            AndroidNotificationDetails(



          'alarm_channel_v2',


          'Alarm Reminder',



          channelDescription:
              'Alarm pengingat',




          importance:
              Importance.max,



          priority:
              Priority.high,



          playSound:
              true,



          sound:
              RawResourceAndroidNotificationSound(
                'alarm',
              ),



          enableVibration:
              true,



          fullScreenIntent:
              true,



        ),



      ),






      androidScheduleMode:

          AndroidScheduleMode.exactAllowWhileIdle,



    );




  }





}