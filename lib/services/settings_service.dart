import 'package:shared_preferences/shared_preferences.dart';


class SettingsService {


  //========================
  // THEME
  //========================

  static const String themeKey =
      "theme_mode";


  static Future<void> saveTheme(String value) async {

    final prefs =
    await SharedPreferences.getInstance();


    await prefs.setString(
      themeKey,
      value,
    );

  }



  static Future<String> getTheme() async {

    final prefs =
    await SharedPreferences.getInstance();


    return prefs.getString(
      themeKey,
    ) ??
        "system";

  }





  //========================
  // RINGTONE
  //========================


  static const String ringtoneKey =
      "ringtone";



  static Future<void> saveRingtone(String value) async {

    final prefs =
    await SharedPreferences.getInstance();


    await prefs.setString(
      ringtoneKey,
      value,
    );

  }




  static Future<String> getRingtone() async {

    final prefs =
    await SharedPreferences.getInstance();


    return prefs.getString(
      ringtoneKey,
    ) ??
        "default";

  }







  //========================
  // SNOOZE
  //========================


  static const String snoozeKey =
      "snooze";



  // pilihan durasi snooze
  static const List<int> snoozeOptions = [

    1,

    3,

    5,

    10,

    15,

    30,

  ];





  static Future<void> saveSnooze(int value) async {


    final prefs =
    await SharedPreferences.getInstance();



    await prefs.setInt(

      snoozeKey,

      value,

    );


  }





  static Future<int> getSnooze() async {


    final prefs =
    await SharedPreferences.getInstance();




    return prefs.getInt(

      snoozeKey,

    ) ??
        5;


  }









  //========================
  // VIBRATION
  //========================


  static const String vibrationKey =
      "vibration";



  static Future<void> saveVibration(bool value) async {


    final prefs =
    await SharedPreferences.getInstance();



    await prefs.setBool(

      vibrationKey,

      value,

    );


  }





  static Future<bool> getVibration() async {


    final prefs =
    await SharedPreferences.getInstance();



    return prefs.getBool(

      vibrationKey,

    ) ??

        true;


  }









  //========================
  // FULLSCREEN
  //========================


  static const String fullscreenKey =
      "fullscreen";



  static Future<void> saveFullscreen(bool value) async {


    final prefs =
    await SharedPreferences.getInstance();



    await prefs.setBool(

      fullscreenKey,

      value,

    );


  }





  static Future<bool> getFullscreen() async {


    final prefs =
    await SharedPreferences.getInstance();



    return prefs.getBool(

      fullscreenKey,

    ) ??

        true;


  }


}