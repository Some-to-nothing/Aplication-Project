import 'package:permission_handler/permission_handler.dart';


class PermissionService {


  static Future<void> requestAll() async {


    await Permission.notification.request();


    await Permission.ignoreBatteryOptimizations.request();


  }


}