import 'package:flutter/material.dart';

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
              "PROKELOM V3",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              "Developed by Rizqy & Miko",
            ),
          ),

          const Divider(),

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

            applicationName: "PROKELOM V3",

            applicationVersion: "3.0.0",

            applicationLegalese:
                "© Rizqy & Miko",

          ),

        ],
      ),
    );
  }
}