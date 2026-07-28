import '../../services/notification_service.dart';
import '../../services/settings_service.dart';

import '../../database/db_helper.dart';

import 'alarm_player.dart';

class AlarmController {
  AlarmController._();

  static Future<void> startAlarm() async {
    await AlarmPlayer.play();
  }

  //==========================
  // STOP ALARM
  //==========================

  static Future<void> stopAlarm({
    required int eventId,
    required int notificationId,
  }) async {
    // Stop suara
    await AlarmPlayer.stop();

    // Hapus notification
    await NotificationService.cancel(notificationId);

    // Ubah status reminder menjadi selesai
    await DBHelper.updateStatus(
      eventId,
      "done",
    );
  }

  //==========================
  // SNOOZE
  //==========================

  static Future<void> snoozeAlarm({
    required int eventId,
    required int notificationId,
    required String title,
    required String body,
  }) async {
    // Stop suara
    await AlarmPlayer.stop();

    // Batalkan notification lama
    await NotificationService.cancel(notificationId);

    // Ambil setting snooze
    final int snoozeMinute =
        await SettingsService.getSnooze();

    // Bersihkan judul supaya tidak menjadi
    // (Snooze) (Snooze)
    String cleanTitle = title
        .replaceAll("(Snooze)", "")
        .trim();

    // Hitung alarm berikutnya
    DateTime nextAlarm = DateTime.now()
        .add(Duration(minutes: snoozeMinute));

    // Reset detik supaya lebih konsisten
    nextAlarm = DateTime(
      nextAlarm.year,
      nextAlarm.month,
      nextAlarm.day,
      nextAlarm.hour,
      nextAlarm.minute,
    );

    // Jadwalkan ulang
    await NotificationService.schedule(
      id: eventId,
      title: "$cleanTitle (Snooze)",
      body: body,
      time: nextAlarm,
    );
  }

  //==========================
  // TEST
  //==========================

  static Future<void> testAlarm() async {
    await startAlarm();
  }
}