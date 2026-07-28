import 'package:flutter/material.dart';

import '../../services/settings_service.dart';
import '../../services/notification_service.dart';

class AlarmSettingPage extends StatefulWidget {
  const AlarmSettingPage({
    super.key,
  });

  @override
  State<AlarmSettingPage> createState() =>
      _AlarmSettingPageState();
}

class _AlarmSettingPageState
    extends State<AlarmSettingPage> {

  String ringtone = "default";

  int snooze = 10;

  bool vibration = true;

  bool fullscreen = true;

  @override
  void initState() {

    super.initState();

    loadSettings();

  }

  Future<void> loadSettings() async {

    ringtone =
        await SettingsService.getRingtone();

    snooze =
        await SettingsService.getSnooze();

    vibration =
        await SettingsService.getVibration();

    fullscreen =
        await SettingsService.getFullscreen();

    setState(() {});

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text(
          "Pengaturan Alarm",
        ),

        centerTitle: true,

      ),

      body: ListView(

        children: [

          const SizedBox(height: 10),

          //========================
          // RINGTONE
          //========================

          const ListTile(

            leading: Icon(Icons.music_note),

            title: Text(
              "Nada Dering",
            ),

          ),

          RadioListTile<String>(

            value: "default",

            groupValue: ringtone,

            title: const Text("Default"),

            onChanged: (value) async {

              await SettingsService.saveRingtone(value!);

              setState(() {

                ringtone = value;

              });

            },

          ),

          const Divider(),

          //========================
          // SNOOZE
          //========================

          const ListTile(

            leading: Icon(Icons.snooze),

            title: Text(
              "Durasi Snooze",
            ),

          ),

...SettingsService.snoozeOptions.map(

  (minute) {

    return RadioListTile<int>(

      value: minute,

      groupValue: snooze,

      title: Text("$minute Menit"),

      onChanged: (value) async {

        await SettingsService.saveSnooze(value!);


        setState(() {

          snooze = value;

        });


      },

    );

  },

),

          const Divider(),

          //========================
          // VIBRATION
          //========================

          SwitchListTile(

            secondary: const Icon(Icons.vibration),

            title: const Text(
              "Getar",
            ),

            value: vibration,

            onChanged: (value) async {

              await SettingsService.saveVibration(value);

              setState(() {

                vibration = value;

              });

            },

          ),

          //========================
          // FULLSCREEN
          //========================

          SwitchListTile(

            secondary: const Icon(Icons.fullscreen),

            title: const Text(
              "Fullscreen Alarm",
            ),

            value: fullscreen,

            onChanged: (value) async {

              await SettingsService.saveFullscreen(value);

              setState(() {

                fullscreen = value;

              });

            },

          ),

          const Divider(),

          Padding(

            padding: const EdgeInsets.all(15),

            child: ElevatedButton.icon(

              icon: const Icon(Icons.notifications_active),

              label: const Text(
                "TEST ALARM",
              ),

              onPressed: () async {

                await NotificationService.testAlarm();

                if (!context.mounted) return;

                ScaffoldMessenger.of(context).showSnackBar(

                  const SnackBar(

                    content: Text(
                      "Alarm percobaan dikirim.",
                    ),

                  ),

                );

              },

            ),

          ),

        ],

      ),

    );

  }

}