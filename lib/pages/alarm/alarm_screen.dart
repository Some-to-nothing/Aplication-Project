import 'package:flutter/material.dart';

import 'alarm_controller.dart';


class AlarmScreen extends StatefulWidget {


  final String title;

  final String body;

  final int eventId;

  final int notificationId;



  const AlarmScreen({

    super.key,

    required this.title,

    required this.body,

    required this.eventId,

    required this.notificationId,

  });



  @override
  State<AlarmScreen> createState() =>
      _AlarmScreenState();

}







class _AlarmScreenState
    extends State<AlarmScreen> {




  @override
  void initState() {

    super.initState();

    startAlarm();

  }







  Future<void> startAlarm() async {

    await AlarmController.startAlarm();

  }







  Future<void> stopAlarm() async {


    await AlarmController.stopAlarm(

      eventId:
      widget.eventId,


      notificationId:
      widget.notificationId,


    );



    if(mounted){


      Navigator.pop(context);


    }


  }









  Future<void> snoozeAlarm() async {


    await AlarmController.snoozeAlarm(

      eventId:
      widget.eventId,


      notificationId:
      widget.notificationId,


      title:
      widget.title,


      body:
      widget.body,


    );



    if(mounted){


      Navigator.pop(context);


    }


  }










  @override
  Widget build(BuildContext context) {


    return Scaffold(


      backgroundColor:
      Colors.black,



      body:

      SafeArea(



        child:

        Padding(



          padding:

          const EdgeInsets.all(30),




          child:

          Column(



            mainAxisAlignment:

            MainAxisAlignment.center,



            children: [





              const Icon(


                Icons.alarm,


                color:
                Colors.white,


                size:
                90,


              ),







              const SizedBox(

                height:30,

              ),







              const Text(



                "PROKELOM V3",



                style:

                TextStyle(



                  color:
                  Colors.white,



                  fontSize:
                  30,



                  fontWeight:
                  FontWeight.bold,



                ),



              ),









              const SizedBox(

                height:40,

              ),







              Text(



                widget.title,



                textAlign:

                TextAlign.center,



                style:

                const TextStyle(



                  color:
                  Colors.white,



                  fontSize:
                  26,



                  fontWeight:
                  FontWeight.bold,



                ),



              ),







              const SizedBox(

                height:15,

              ),









              Text(



                widget.body,



                textAlign:

                TextAlign.center,



                style:

                const TextStyle(



                  color:
                  Colors.white70,



                  fontSize:
                  18,



                ),



              ),









              const SizedBox(

                height:60,

              ),







              SizedBox(



                width:

                double.infinity,



                height:

                55,



                child:

                ElevatedButton(



                  onPressed:

                  snoozeAlarm,



                  child:

                  const Text(



                    "SNOOZE",



                    style:

                    TextStyle(



                      fontSize:

                      18,



                    ),



                  ),



                ),



              ),







              const SizedBox(

                height:20,

              ),









              SizedBox(



                width:

                double.infinity,



                height:

                55,



                child:

                ElevatedButton(



                  style:

                  ElevatedButton.styleFrom(



                    backgroundColor:

                    Colors.red,



                  ),



                  onPressed:

                  stopAlarm,



                  child:

                  const Text(



                    "MATIKAN ALARM",



                    style:

                    TextStyle(



                      color:
                      Colors.white,



                      fontSize:
                      18,



                    ),



                  ),



                ),



              ),





            ],



          ),



        ),



      ),



    );


  }


}