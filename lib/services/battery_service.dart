import 'package:permission_handler/permission_handler.dart';


class BatteryService {


  static Future<void> requestIgnoreBattery() async {


    try {


      final status =
          await Permission.ignoreBatteryOptimizations.status;



      if(status.isDenied){


        await Permission
            .ignoreBatteryOptimizations
            .request();


      }



    } catch(e){


      print(
        "BATTERY PERMISSION ERROR : $e",
      );


    }


  }



}