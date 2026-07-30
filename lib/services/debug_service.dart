import 'package:shared_preferences/shared_preferences.dart';

class DebugService {

  static Future<void> log(String text) async {

    final prefs =
        await SharedPreferences.getInstance();

    final old =
        prefs.getStringList("debug_log") ?? [];

    old.add(
      "${DateTime.now()} : $text",
    );

    await prefs.setStringList(
      "debug_log",
      old,
    );
  }


  static Future<List<String>> getLogs() async {

    final prefs =
        await SharedPreferences.getInstance();

    return prefs.getStringList(
      "debug_log",
    ) ?? [];

  }


}