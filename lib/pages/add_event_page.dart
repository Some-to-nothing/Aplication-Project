import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../database/db_helper.dart';
import '../models/event_model.dart';
import '../services/notification_service.dart';



class AddEventPage extends StatefulWidget {

  const AddEventPage({
    super.key,
  });


  @override
  State<AddEventPage> createState() =>
      _AddEventPageState();

}




class _AddEventPageState extends State<AddEventPage> {



  final titleController =
      TextEditingController();


  final noteController =
      TextEditingController();




  DateTime selectedDate =
      DateTime.now();



  TimeOfDay selectedTime =
      TimeOfDay.now();







  Future<void> pickDate() async {


    DateTime? picked =
    await showDatePicker(


      context: context,


      initialDate:
      selectedDate,


      firstDate:
      DateTime(2024),


      lastDate:
      DateTime(2035),


    );



    if(picked != null){


      setState(() {


        selectedDate =
            picked;


      });


    }


  }








  Future<void> pickTime() async {


    TimeOfDay? picked =
    await showTimePicker(


      context: context,


      initialTime:
      selectedTime,


    );



    if(picked != null){


      setState(() {


        selectedTime =
            picked;


      });


    }


  }









  Future<void> saveEvent() async {



    if(titleController.text.trim().isEmpty){


      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(

          content:
          Text(
            "Judul kegiatan wajib diisi",
          ),

        ),

      );


      return;

    }






    DateTime alarmTime = DateTime(


      selectedDate.year,


      selectedDate.month,


      selectedDate.day,


      selectedTime.hour,


      selectedTime.minute,


    );






    print(
      "NOW : ${DateTime.now()}"
    );


    print(
      "ALARM TIME : $alarmTime"
    );





    if(alarmTime.isBefore(DateTime.now())){


      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(

          content:
          Text(
            "Waktu alarm sudah lewat",
          ),

        ),

      );


      return;

    }








    final event = EventModel(


      title:
      titleController.text,


      note:
      noteController.text,


      date:
      DateFormat(
        'yyyy-MM-dd',
      )
          .format(selectedDate),


      time:
      selectedTime.format(context),


    );






    int id =
    await DBHelper.insert(
      event,
    );







    await NotificationService.schedule(


      id:
      id,


      title:
      titleController.text,


      body:
      noteController.text,


      time:
      alarmTime,


    );






    print(
      "EVENT SAVED ID : $id"
    );







    if(!mounted) return;







    ScaffoldMessenger.of(context)
        .showSnackBar(

      const SnackBar(

        content:
        Text(
          "Jadwal berhasil disimpan",
        ),

      ),

    );






    Navigator.pop(
      context,
      true,
    );



  }









  @override
  void dispose(){


    titleController.dispose();


    noteController.dispose();



    super.dispose();


  }









  @override
  Widget build(BuildContext context) {


    return Scaffold(



      appBar:
      AppBar(


        title:
        const Text(
          "Tambah Jadwal",
        ),


      ),







      body:
      Padding(



        padding:
        const EdgeInsets.all(15),





        child:
        ListView(



          children: [






            TextField(



              controller:
              titleController,



              decoration:
              const InputDecoration(



                labelText:
                "Judul",



                border:
                OutlineInputBorder(),



              ),



            ),








            const SizedBox(
              height:15,
            ),








            TextField(



              controller:
              noteController,



              maxLines:
              4,



              decoration:
              const InputDecoration(



                labelText:
                "Catatan",



                border:
                OutlineInputBorder(),



              ),



            ),







            const SizedBox(
              height:20,
            ),







            ListTile(



              leading:
              const Icon(
                Icons.calendar_month,
              ),



              title:
              const Text(
                "Tanggal",
              ),



              subtitle:
              Text(

                DateFormat(
                  'dd MMMM yyyy',
                )
                    .format(selectedDate),

              ),





              trailing:
              ElevatedButton(



                onPressed:
                pickDate,



                child:
                const Text(
                  "Pilih",
                ),



              ),



            ),







            const SizedBox(
              height:10,
            ),







            ListTile(



              leading:
              const Icon(
                Icons.access_time,
              ),



              title:
              const Text(
                "Jam",
              ),



              subtitle:
              Text(

                selectedTime.format(
                  context,
                ),

              ),





              trailing:
              ElevatedButton(



                onPressed:
                pickTime,



                child:
                const Text(
                  "Pilih",
                ),



              ),



            ),








            const SizedBox(
              height:40,
            ),








            SizedBox(



              height:
              55,



              child:
              ElevatedButton.icon(



                onPressed:
                saveEvent,



                icon:
                const Icon(
                  Icons.save,
                ),



                label:
                const Text(


                  "Simpan Jadwal",


                  style:
                  TextStyle(
                    fontSize:18,
                  ),


                ),



              ),



            ),





          ],



        ),



      ),



    );


  }


}