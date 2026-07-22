import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../database/db_helper.dart';
import '../models/event_model.dart';
import '../services/notification_service.dart';

import 'add_event_page.dart';



class HomePage extends StatefulWidget {

  const HomePage({
    super.key,
  });


  @override
  State<HomePage> createState() => _HomePageState();

}




class _HomePageState extends State<HomePage> {


  DateTime selectedDay = DateTime.now();

  DateTime focusedDay = DateTime.now();



  List<EventModel> allEvents = [];

  List<EventModel> todayEvents = [];




  @override
  void initState() {

    super.initState();

    loadEvents();

  }





  Future<void> loadEvents() async {


    allEvents = await DBHelper.getEvents();

    filterEvents();


  }






  void filterEvents() {


    String date =
    DateFormat('yyyy-MM-dd')
        .format(selectedDay);



    todayEvents =
        allEvents
            .where(
              (e) => e.date == date,
        )
            .toList();



    setState(() {});


  }







  bool hasEvent(DateTime day) {


    String date =
    DateFormat('yyyy-MM-dd')
        .format(day);



    return allEvents.any(
            (e) => e.date == date
    );


  }








  @override
  Widget build(BuildContext context) {


    return Scaffold(



      appBar: AppBar(


        title:
        const Text(
          "Prokelom V2",
        ),


        centerTitle:
        true,



        actions: [



          IconButton(


            icon:
            const Icon(
              Icons.notifications,
            ),



            onPressed: () async {


              await NotificationService.testAlarm();


            },


          ),



        ],



      ),







      floatingActionButton:
      FloatingActionButton(



        child:
        const Icon(
          Icons.add,
        ),



        onPressed: () async {



          await Navigator.push(


            context,


            MaterialPageRoute(


              builder: (_) =>
              const AddEventPage(),


            ),


          );



          loadEvents();



        },



      ),







      body:
      Column(



        children: [




          TableCalendar(



            firstDay:
            DateTime(2024),



            lastDay:
            DateTime(2035),



            focusedDay:
            focusedDay,





            selectedDayPredicate:
                (day) {



              return isSameDay(
                selectedDay,
                day,
              );


            },





            onDaySelected:
                (selected, focused) {



              selectedDay =
                  selected;


              focusedDay =
                  focused;



              filterEvents();



            },







            calendarStyle:
            const CalendarStyle(



              todayDecoration:
              BoxDecoration(



                color:
                Colors.blue,



                shape:
                BoxShape.circle,



              ),





              selectedDecoration:
              BoxDecoration(



                color:
                Colors.red,



                shape:
                BoxShape.circle,



              ),



            ),







            calendarBuilders:
            CalendarBuilders(



              markerBuilder:
                  (context, day, events) {



                if(hasEvent(day)){



                  return Align(



                    alignment:
                    Alignment.bottomCenter,



                    child:
                    Container(



                      width:
                      7,



                      height:
                      7,



                      decoration:
                      const BoxDecoration(



                        color:
                        Colors.green,



                        shape:
                        BoxShape.circle,



                      ),



                    ),



                  );



                }



                return const SizedBox();



              },



            ),




          ),







          const SizedBox(
            height:10,
          ),







          Container(



            width:
            double.infinity,



            padding:
            const EdgeInsets.all(15),



            color:
            Colors.blue.shade50,



            child:
            Text(



              "Jadwal ${DateFormat('dd MMM yyyy').format(selectedDay)}",



              style:
              const TextStyle(



                fontWeight:
                FontWeight.bold,



                fontSize:
                18,



              ),



            ),



          ),







          Expanded(



            child:
            todayEvents.isEmpty



                ?

            const Center(



              child:
              Text(



                "Belum ada kegiatan",



                style:
                TextStyle(
                    fontSize:18
                ),



              ),



            )



                :



            ListView.builder(



              itemCount:
              todayEvents.length,



              itemBuilder:
                  (context,index){



                final event =
                todayEvents[index];





                return Card(



                  margin:
                  const EdgeInsets.symmetric(



                    horizontal:10,

                    vertical:6,



                  ),





                  child:
                  ListTile(



                    leading:
                    const Icon(



                      Icons.alarm,

                      color:
                      Colors.red,



                    ),





                    title:
                    Text(
                      event.title,
                    ),





                    subtitle:
                    Column(



                      crossAxisAlignment:
                      CrossAxisAlignment.start,



                      children: [



                        Text(
                          event.note,
                        ),



                        const SizedBox(
                          height:5,
                        ),



                        Text(
                          "${event.date}   ${event.time}",
                        ),



                      ],



                    ),





                    trailing:
                    const Icon(
                      Icons.arrow_forward_ios,
                      size:18,
                    ),



                  ),



                );



              },



            ),



          ),




        ],



      ),



    );


  }


}