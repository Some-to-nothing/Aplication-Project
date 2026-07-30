import 'package:flutter/material.dart';
import '../../services/debug_service.dart';
import 'background_setting_page.dart';
import 'theme_setting_page.dart';
import 'alarm_setting_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pengaturan"),
        centerTitle: true,
      ),

      body: ListView(

        children: [

          const SizedBox(height: 15),

          const ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.calendar_month),
            ),

            title: Text(
              "RemindUs",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            subtitle: Text(
              "Never Miss What Matters",
            ),
          ),


          const Divider(),

          ElevatedButton.icon(
  icon: const Icon(Icons.bug_report),
  label: const Text("Lihat Debug Log"),
  onPressed: () async {

    final logs =
        await DebugService.getLogs();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(

        title:
        const Text(
          "Debug Log",
        ),

        content:
        SizedBox(
          width: double.maxFinite,

          child:
          SingleChildScrollView(

            child:
            Text(

              logs.isEmpty
                  ? "Belum ada log"
                  : logs.join("\n\n"),

            ),

          ),

        ),

      ),
    );

  },
),
          ListTile(
            leading: const Icon(Icons.image),
            title: const Text("Background"),

            trailing: const Icon(Icons.chevron_right),

            onTap: () {

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const BackgroundSettingPage(),
                ),
              );

            },
          ),



          ListTile(
            leading: const Icon(Icons.dark_mode),
            title: const Text("Tema"),

            trailing: const Icon(Icons.chevron_right),

            onTap: () {

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const ThemeSettingPage(),
                ),
              );

            },
          ),



          ListTile(
            leading: const Icon(Icons.alarm),
            title: const Text("Alarm"),

            trailing: const Icon(Icons.chevron_right),

            onTap: () {

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const AlarmSettingPage(),
                ),
              );

            },
          ),



          const Divider(),



          const AboutListTile(

            icon: Icon(Icons.info),


            applicationName:
            "RemindUs",


            applicationVersion:
            "1.0.0",


            applicationLegalese:
            """
Never Miss What Matters
Your Personal Reminder

Developed by:
Rizqy Fadillah & Miko

Software Engineering (RPL) XII
SMKS Jakarta Pusat 1

© 2026 RemindUs
All Rights Reserved.
""",

          ),


        ],
      ),
    );
  }
}