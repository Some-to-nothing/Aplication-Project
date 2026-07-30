import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../database/db_helper.dart';
import '../../models/event_model.dart';
import '../../services/notification_service.dart';





class EditEventPage extends StatefulWidget {


  final EventModel event;



  const EditEventPage({

    super.key,

    required this.event,

  });




  @override
  State<EditEventPage> createState() =>
      _EditEventPageState();



}









class _EditEventPageState extends State<EditEventPage> {



  late TextEditingController titleController;


  late TextEditingController noteController;





  late DateTime selectedDate;


  late TimeOfDay selectedTime;









  @override
  void initState(){


    super.initState();



    titleController =
        TextEditingController(


          text:
          widget.event.title,


        );



    noteController =
        TextEditingController(


          text:
          widget.event.note,


        );





selectedDate = DateTime.tryParse(
  widget.event.date,
) ?? DateTime.now();





    selectedTime =
        parseTime(


          widget.event.time,


        );



  }









  TimeOfDay parseTime(String time){


    List<String> data =
    time.split(":");



    return TimeOfDay(


      hour:
      int.parse(data[0]),


      minute:
      int.parse(data[1]),


    );


  }









  Future<void> pickDate() async {



    DateTime? picked =
    await showDatePicker(



      context:
      context,



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



      context:
      context,



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












  Future<void> updateEvent() async {




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









    EventModel event =
    EventModel(



      id:
      widget.event.id,



      title:
      titleController.text.trim(),



      note:
      noteController.text.trim(),



      date:
      DateFormat(
        'yyyy-MM-dd',
      ).format(selectedDate),



      time:
      selectedTime.format(context),



      status:
      widget.event.status,



    );









    // CANCEL ALARM LAMA

    await NotificationService.cancel(


      widget.event.id!,


    );








    // UPDATE DATABASE


    await DBHelper.update(


      event,


    );









    // BUAT ALARM BARU


    await NotificationService.schedule(


  id:
  event.id!,


  eventId:
  event.id!,


  title:
  event.title,


  body:
  event.note,


  time:
  alarmTime,


);









    if(!mounted)return;





    ScaffoldMessenger.of(context)
        .showSnackBar(



      const SnackBar(



        content:
        Text(
          "Jadwal berhasil diperbarui",
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
  Widget build(BuildContext context){



    return Scaffold(




      appBar:
      AppBar(



        title:
        const Text(
          "Edit Jadwal",
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
                ).format(selectedDate),


              ),



              trailing:
              ElevatedButton(



                onPressed:
                pickDate,



                child:
                const Text(
                  "Ubah",
                ),



              ),



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
                  "Ubah",
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
                updateEvent,



                icon:
                const Icon(
                  Icons.save,
                ),



                label:
                const Text(



                  "Simpan Perubahan",



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