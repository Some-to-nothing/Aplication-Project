import '../../services/notification_service.dart';
import '../../services/settings_service.dart';
import '../../database/db_helper.dart';

class AlarmController {


  AlarmController._();





  //==========================
  // START ALARM
  //==========================

  static Future<void> startAlarm({

    required int eventId,

  }) async {


    // Update status saja.
    // Sound sudah ditangani Android Notification.

    await DBHelper.updateStatus(

      eventId,

      "ringing",

    );


    print(
      "ALARM STARTED : EVENT $eventId",
    );


  }









  //==========================
  // STOP ALARM
  //==========================

  static Future<void> stopAlarm({

    required int eventId,

    required int notificationId,

  }) async {


    // Hentikan notification Android

    await NotificationService.cancel(

      notificationId,

    );



    // Update database

    await DBHelper.updateStatus(

      eventId,

      "done",

    );


    print(
      "ALARM STOPPED : EVENT $eventId",
    );


  }









  //==========================
  // SNOOZE ALARM
  //==========================

  static Future<void> snoozeAlarm({

    required int eventId,

    required int notificationId,

    required String title,

    required String body,

  }) async {



    // Hentikan alarm Android sekarang

    await NotificationService.cancel(

      notificationId,

    );





    // Update status

    await DBHelper.updateStatus(

      eventId,

      "snoozed",

    );







    // Ambil setting snooze

    final int snoozeMinute =

    await SettingsService.getSnooze();







    // Bersihkan title lama

    final String cleanTitle =

    title

        .replaceAll(

      "(Snooze)",

      "",

    )

        .trim();







    // Waktu alarm berikutnya

    DateTime nextAlarm =

    DateTime.now().add(

      Duration(

        minutes: snoozeMinute,

      ),

    );





    // Reset detik

    nextAlarm = DateTime(

      nextAlarm.year,

      nextAlarm.month,

      nextAlarm.day,

      nextAlarm.hour,

      nextAlarm.minute,

    );









    // ID baru

    final int snoozeNotificationId =

        eventId * 1000 +

            DateTime.now()

                .millisecondsSinceEpoch %

                1000;







    print(
      "===== SNOOZE DEBUG =====",
    );

    print(
      "EVENT ID : $eventId",
    );

    print(
      "OLD NOTIFICATION ID : $notificationId",
    );

    print(
      "NEW NOTIFICATION ID : $snoozeNotificationId",
    );

    print(
      "TIME : $nextAlarm",
    );

    print(
      "========================",
    );









    // Buat notification baru

    await NotificationService.schedule(


      id:

      snoozeNotificationId,


      eventId:

      eventId,


      title:

      "$cleanTitle (Snooze)",


      body:

      body,


      time:

      nextAlarm,


    );



  }









  //==========================
  // TEST ALARM
  //==========================

  static Future<void> testAlarm() async {


    await NotificationService.testAlarm();


  }



}