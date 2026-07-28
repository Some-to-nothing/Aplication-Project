import 'package:flutter/material.dart';
import '../../main.dart';
import '../../services/settings_service.dart';

class ThemeSettingPage extends StatefulWidget {
  const ThemeSettingPage({super.key});

  @override
  State<ThemeSettingPage> createState() =>
      _ThemeSettingPageState();
}

class _ThemeSettingPageState
    extends State<ThemeSettingPage> {

  String selected = "system";

  @override
  void initState() {
    super.initState();
    loadTheme();
  }

  Future<void> loadTheme() async {
    selected = await SettingsService.getTheme();
    setState(() {});
  }

  Future<void> save(String value) async {

  await SettingsService.saveTheme(value);

  switch (value) {

    case "light":
      themeNotifier.value =
          ThemeMode.light;
      break;

    case "dark":
      themeNotifier.value =
          ThemeMode.dark;
      break;

    default:
      themeNotifier.value =
          ThemeMode.system;

  }

  setState(() {

    selected = value;

  });

  if (!mounted) return;

  ScaffoldMessenger.of(context).showSnackBar(

    const SnackBar(

      content:
      Text(
        "Tema berhasil disimpan",
      ),

    ),

  );

}

  Widget item(String title, String value, IconData icon) {
    return RadioListTile<String>(
      value: value,
      groupValue: selected,
      secondary: Icon(icon),
      title: Text(title),
      onChanged: (v) {
        if (v != null) {
          save(v);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tema"),
      ),
      body: ListView(
        children: [
          item(
            "Terang",
            "light",
            Icons.light_mode,
          ),
          item(
            "Gelap",
            "dark",
            Icons.dark_mode,
          ),
          item(
            "Ikuti Sistem",
            "system",
            Icons.phone_android,
          ),
        ],
      ),
    );
  }
}