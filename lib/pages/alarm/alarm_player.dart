import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:vibration/vibration.dart';


class AlarmPlayer {


  static final AudioPlayer _player =
      AudioPlayer();


  static Timer? _timer;



  static Future<void> play() async {


    await stop();


    await _player.setReleaseMode(
      ReleaseMode.loop,
    );


    await _player.play(

      AssetSource(
        "sounds/alarm_default.mp3",
      ),

    );


    if(await Vibration.hasVibrator()){

      Vibration.vibrate(

        pattern:[
          0,
          1000,
          500,
          1000,
        ],

      );

    }



    // maksimal 5 menit

    _timer =
        Timer(

          const Duration(
            minutes:5,
          ),

          () async {

            await stop();

          },

        );


  }







  static Future<void> stop() async {


    _timer?.cancel();


    await _player.stop();



    if(await Vibration.hasVibrator()){

      Vibration.cancel();

    }


  }



}