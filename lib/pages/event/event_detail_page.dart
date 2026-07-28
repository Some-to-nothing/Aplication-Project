import 'package:flutter/material.dart';

import '../../models/event_model.dart';
import '../../database/db_helper.dart';
import '../../services/notification_service.dart';

import 'edit_event_page.dart';





class EventDetailPage extends StatefulWidget {


  final EventModel event;



  const EventDetailPage({

    super.key,

    required this.event,

  });




  @override
  State<EventDetailPage> createState() =>
      _EventDetailPageState();



}









class _EventDetailPageState extends State<EventDetailPage> {



  late EventModel event;



  @override
  void initState(){


    super.initState();


    event =
        widget.event;


  }









  Future<void> editEvent() async {



    final result =
    await Navigator.push(



      context,



      MaterialPageRoute(



        builder: (_) =>

        EditEventPage(

          event:event,

        ),



      ),



    );





    if(result == true){


      if(!mounted)return;



      Navigator.pop(

        context,

        true,

      );


    }



  }









  Future<void> deleteEvent() async {



    await NotificationService.cancel(

      event.id!,

    );



    await DBHelper.delete(

      event.id!,

    );





    if(!mounted)return;



    Navigator.pop(

      context,

      true,

    );



  }









  @override
  Widget build(BuildContext context){



    return Scaffold(



      appBar: AppBar(



        title:
        const Text(

          "Detail Jadwal",

        ),


        centerTitle:
        true,



      ),









      body:
      Padding(



        padding:
        const EdgeInsets.all(20),



        child:
        Column(



          crossAxisAlignment:
          CrossAxisAlignment.start,



          children: [







            const Icon(



              Icons.event,



              size:
              80,



              color:
              Colors.blue,



            ),







            const SizedBox(
              height:25,
            ),







            const Text(



              "Judul",



              style:
              TextStyle(



                fontWeight:
                FontWeight.bold,



              ),



            ),







            const SizedBox(
              height:5,
            ),







            Text(



              event.title,



              style:
              const TextStyle(



                fontSize:
                22,



              ),



            ),







            const Divider(
              height:35,
            ),







            const Text(



              "Catatan",



              style:
              TextStyle(



                fontWeight:
                FontWeight.bold,



              ),



            ),







            const SizedBox(
              height:5,
            ),







            Text(



              event.note.isEmpty

                  ? "-"

                  : event.note,



              style:
              const TextStyle(



                fontSize:
                18,



              ),



            ),







            const Divider(
              height:35,
            ),







            const Text(



              "Tanggal",



              style:
              TextStyle(



                fontWeight:
                FontWeight.bold,



              ),



            ),







            const SizedBox(
              height:5,
            ),







            Text(



              event.date,



              style:
              const TextStyle(



                fontSize:
                18,



              ),



            ),







            const Divider(
              height:35,
            ),







            const Text(



              "Jam",



              style:
              TextStyle(



                fontWeight:
                FontWeight.bold,



              ),



            ),







            const SizedBox(
              height:5,
            ),







            Text(



              event.time,



              style:
              const TextStyle(



                fontSize:
                18,



              ),



            ),







            const Spacer(),









            SizedBox(



              width:
              double.infinity,



              height:
              50,



              child:
              ElevatedButton.icon(



                onPressed:
                editEvent,



                icon:
                const Icon(

                  Icons.edit,

                ),



                label:
                const Text(

                  "Edit Jadwal",

                ),



              ),



            ),







            const SizedBox(
              height:12,
            ),









            SizedBox(



              width:
              double.infinity,



              height:
              50,



              child:
              ElevatedButton.icon(



                style:
                ElevatedButton.styleFrom(



                  backgroundColor:
                  Colors.red,



                ),



                onPressed:
                deleteEvent,



                icon:
                const Icon(

                  Icons.delete,

                ),



                label:
                const Text(

                  "Hapus Jadwal",

                ),



              ),



            ),





          ],



        ),



      ),



    );



  }



}