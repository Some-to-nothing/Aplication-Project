import 'package:shared_preferences/shared_preferences.dart';


class StorageService {



  // ==========================
  // ONBOARDING
  // ==========================

  static const String onboardingKey =
      "onboarding_completed";



  static Future<bool> isOnboardingDone() async {


    final prefs =
        await SharedPreferences.getInstance();


    return prefs.getBool(
      onboardingKey,
    ) ?? false;


  }





  static Future<void> completeOnboarding() async {


    final prefs =
        await SharedPreferences.getInstance();



    await prefs.setBool(
      onboardingKey,
      true,
    );


  }





  static Future<void> resetOnboarding() async {


    final prefs =
        await SharedPreferences.getInstance();



    await prefs.remove(
      onboardingKey,
    );


  }







  // ==========================
  // BACKGROUND
  // ==========================


  static const String backgroundKey =
      "app_background";





  static Future<void> saveBackground(
      String background
      ) async {


    final prefs =
        await SharedPreferences.getInstance();



    await prefs.setString(

      backgroundKey,

      background,

    );


  }







  static Future<String> getBackground() async {


    final prefs =
        await SharedPreferences.getInstance();



    return prefs.getString(

      backgroundKey,

    ) ?? "default";


  }





  // ==========================
  // THEME (SIAP UNTUK PHASE 2.3)
  // ==========================


  static const String themeKey =
      "app_theme";





  static Future<void> saveTheme(
      String theme
      ) async {


    final prefs =
        await SharedPreferences.getInstance();



    await prefs.setString(

      themeKey,

      theme,

    );


  }







  static Future<String> getTheme() async {


    final prefs =
        await SharedPreferences.getInstance();



    return prefs.getString(

      themeKey,

    ) ?? "light";


  }





}