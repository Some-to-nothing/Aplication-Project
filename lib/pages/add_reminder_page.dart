import 'package:flutter/material.dart';

import '../services/notification_service.dart';
import '../models/reminder.dart';
import '../database/database_helper.dart';



class AddReminderPage extends StatefulWidget {

  const AddReminderPage({super.key});


  @override
  State<AddReminderPage> createState() =>
      _AddReminderPageState();

}



class _AddReminderPageState extends State<AddReminderPage> {


  final TextEditingController titleController =
      TextEditingController();


  TimeOfDay? selectedTime;



  @override
  void dispose() {

    titleController.dispose();

    super.dispose();

  }





  Future<void> chooseTime() async {


    final result = await showTimePicker(

      context: context,

      initialTime: TimeOfDay.now(),

    );


    if(result != null){

      setState(() {

        selectedTime = result;

      });

    }

  }





  DateTime getReminderDateTime(){


    final now = DateTime.now();



    DateTime reminderTime = DateTime(

      now.year,

      now.month,

      now.day,

      selectedTime!.hour,

      selectedTime!.minute,

    );



    // jika waktu sudah lewat,
    // jadwalkan besok

    if(reminderTime.isBefore(now)){


      reminderTime =
          reminderTime.add(
            const Duration(days: 1),
          );


    }



    return reminderTime;


  }







  Future<void> save() async {

    debugPrint("SAVE BUTTON DITEKAN");


    if(titleController.text.trim().isEmpty ||
        selectedTime == null){


      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(

          content:
              Text(
                "Judul dan waktu harus diisi",
              ),

        ),

      );


      return;

    }







    final reminder = Reminder(


      title:
          titleController.text.trim(),


      time:
          selectedTime!.format(context),


      isActive:
          true,


    );







    // simpan database

    await DatabaseHelper.instance
        .insert(reminder);

    debugPrint("DATABASE BERHASIL");





    // jadwalkan notifikasi

try {

debugPrint("MULAI JADWAL NOTIF");

await NotificationService.scheduleNotification(

    id: DateTime.now()
        .millisecondsSinceEpoch
        .remainder(100000),

    title: reminder.title,

    body: "Waktu reminder sudah tiba",

    time: getReminderDateTime(),

  );


} catch(e) {


  debugPrint(
    "Notif gagal: $e"
  );


}







    if(!mounted) return;



    Navigator.pop(context, true);



  }









  @override
  Widget build(BuildContext context) {


    return Scaffold(


      appBar: AppBar(

        title:
            const Text(
              "Tambah Reminder",
            ),

        backgroundColor:
            Colors.lightBlue,

        foregroundColor:
            Colors.white,

      ),





      body: Padding(

        padding:
            const EdgeInsets.all(20),



        child: Column(


          crossAxisAlignment:
              CrossAxisAlignment.start,



          children: [



            const Text(

              "Judul Reminder",

              style:
                  TextStyle(

                fontSize: 18,

                fontWeight:
                    FontWeight.bold,

              ),

            ),





            const SizedBox(height:10),






            TextField(


              controller:
                  titleController,



              decoration:
                  InputDecoration(

                hintText:
                    "Contoh: Belajar Flutter",


                prefixIcon:
                    const Icon(
                      Icons.title,
                    ),


                border:
                    OutlineInputBorder(

                  borderRadius:
                      BorderRadius.circular(15),

                ),

              ),

            ),






            const SizedBox(height:25),






            const Text(

              "Waktu Reminder",

              style:
                  TextStyle(

                fontSize:18,

                fontWeight:
                    FontWeight.bold,

              ),

            ),






            const SizedBox(height:10),






            InkWell(

              onTap:
                  chooseTime,



              child:
                  Container(

                width:
                    double.infinity,


                padding:
                    const EdgeInsets.all(18),



                decoration:
                    BoxDecoration(

                  border:
                      Border.all(

                    color:
                        Colors.lightBlue,

                  ),


                  borderRadius:
                      BorderRadius.circular(15),


                ),






                child:
                    Row(

                  children: [



                    const Icon(

                      Icons.alarm,

                      color:
                          Colors.lightBlue,

                    ),





                    const SizedBox(
                      width:15,
                    ),





                    Text(

                      selectedTime == null

                      ?

                      "Pilih waktu"

                      :

                      selectedTime!
                          .format(context),


                    ),



                  ],


                ),


              ),


            ),







            const Spacer(),







            SizedBox(

              width:
                  double.infinity,

              height:
                  55,



              child:
                  ElevatedButton(



                onPressed:
                    save,



                style:
                    ElevatedButton.styleFrom(


                  backgroundColor:
                      Colors.lightBlue,


                  foregroundColor:
                      Colors.white,


                ),



                child:
                    const Text(

                  "Simpan Reminder",

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