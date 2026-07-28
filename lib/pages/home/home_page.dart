import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../settings/settings_page.dart';

import '../event/add_event_page.dart';
import '../event/edit_event_page.dart';
import '../event/event_detail_page.dart';

import '../../config/asset_config.dart';

import '../../database/db_helper.dart';
import '../../models/event_model.dart';

import '../../services/notification_service.dart';
import '../../services/storage_service.dart';



class HomePage extends StatefulWidget {


  const HomePage({
    super.key,
  });



  @override
  State<HomePage> createState() =>
      _HomePageState();

}









class _HomePageState extends State<HomePage> {



  DateTime selectedDay =
      DateTime.now();


  DateTime focusedDay =
      DateTime.now();



  List<EventModel> allEvents = [];

  List<EventModel> todayEvents = [];



  String background =
      "default";








  @override
  void initState(){

    super.initState();


    loadEvents();

    loadBackground();


  }









  Future<void> loadBackground() async {


    background =
        await StorageService.getBackground();


    setState(() {});


  }









  Future<void> loadEvents() async {


    allEvents =
        await DBHelper.getEvents();


    filterEvents();


  }









  void filterEvents(){


    String date =
        DateFormat(
          'yyyy-MM-dd',
        ).format(selectedDay);



    todayEvents =
        allEvents
            .where(
              (e)=> e.date == date,
        )
            .toList();



    setState(() {});


  }









  bool hasEvent(DateTime day){


    String date =
        DateFormat(
          'yyyy-MM-dd',
        ).format(day);



    return allEvents.any(
          (e)=> e.date == date,
    );


  }









  Future<void> setDone(
      EventModel event
      ) async {


    await DBHelper.updateStatus(

      event.id!,

      "done",

    );


    await loadEvents();


  }









  Future<void> deleteEvent(
      EventModel event
      ) async {


    await NotificationService.cancel(

      event.id!,

    );



    await DBHelper.delete(

      event.id!,

    );



    await loadEvents();


  }









  Widget getBackground(){



    switch(background){



      case "sky":


        return Image.asset(

          AssetConfig.onboardingSky,

          fit: BoxFit.cover,

          width:
          double.infinity,

          height:
          double.infinity,

        );





      case "grass":


        return Image.asset(

          AssetConfig.onboardingGrass,

          fit: BoxFit.cover,

          width:
          double.infinity,

          height:
          double.infinity,

        );





      case "space":


        return Image.asset(

          AssetConfig.onboardingSpace,

          fit: BoxFit.cover,

          width:
          double.infinity,

          height:
          double.infinity,

        );





      default:


        return Container(

          color:
          Colors.white,

        );



    }



  }









  @override
  Widget build(BuildContext context){


    return Scaffold(





      drawer: Drawer(



        child: ListView(



          children: [



            const UserAccountsDrawerHeader(



              accountName:
              Text(
                "PROKELOM V3",
              ),



              accountEmail:
              Text(
                "Rizqy & Miko",
              ),



              currentAccountPicture:
              CircleAvatar(

                child:
                Icon(

                  Icons.calendar_month,

                  size:35,

                ),

              ),



            ),







            ListTile(



              leading:
              const Icon(
                Icons.settings,
              ),



              title:
              const Text(
                "Pengaturan",
              ),




              onTap: () async {

  Navigator.pop(context);

  await Navigator.push(

    context,

    MaterialPageRoute(

      builder: (_) =>
      const SettingsPage(),

    ),

  );

  await loadBackground();
  await loadEvents();

},



            ),



          ],



        ),



      ),







      appBar:
      AppBar(



        title:
        const Text(
          "PROKELOM V3",
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



              builder: (_)=>
              const AddEventPage(),



            ),



          );



          loadEvents();



        },



      ),










      body:

      Stack(



        children: [



          getBackground(),







          Container(



            color:
            Colors.white.withValues(
              alpha: 0.65,
            ),




            child:

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
                      (day){



                    return isSameDay(

                      selectedDay,

                      day,

                    );



                  },



                  onDaySelected:
                      (selected,focused){



                    setState(() {



                      selectedDay =
                          selected;



                      focusedDay =
                          focused;



                    });



                    filterEvents();



                  },







                  calendarBuilders:
                  CalendarBuilders(



                    markerBuilder:
                        (context,day,events){



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



                      return null;



                    },



                  ),



                ),







                Container(



                  width:
                  double.infinity,



                  padding:
                  const EdgeInsets.all(15),



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
                        fontSize:18,
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



                      bool done =
                          event.status ==
                              "done";






                      return Card(



                        margin:
                        const EdgeInsets.all(10),



                        child:
                        ListTile(



                          onTap: () async {



                            final result =
                            await Navigator.push(



                              context,

                              MaterialPageRoute(



                                builder: (_)=>
                                EventDetailPage(

                                  event:event,

                                ),



                              ),



                            );



                            if(result == true){

                              loadEvents();

                            }



                          },





                          leading:
                          Icon(



                            done
                                ? Icons.check_circle
                                : Icons.alarm,



                            color:
                            done
                                ? Colors.green
                                : Colors.red,



                          ),






                          title:
                          Text(



                            event.title,



                            style:
                            TextStyle(



                              fontWeight:
                              FontWeight.bold,



                              decoration:
                              done
                                  ? TextDecoration.lineThrough
                                  : null,



                            ),



                          ),







                          subtitle:
                          Column(



                            crossAxisAlignment:
                            CrossAxisAlignment.start,



                            children: [



                              Text(
                                event.note,
                              ),



                              Text(
                                "${event.date} ${event.time}",
                              ),



                              Text(



                                done
                                    ? "Status : Selesai"
                                    : "Status : Pending",



                                style:
                                TextStyle(



                                  color:
                                  done
                                      ? Colors.green
                                      : Colors.orange,



                                ),



                              ),



                            ],



                          ),







                          trailing:
                          PopupMenuButton(



                            itemBuilder:
                                (context){



                              return [



                                const PopupMenuItem(

                                  value:"edit",

                                  child:
                                  Text(
                                    "Edit Jadwal",
                                  ),

                                ),





                                if(!done)

                                  const PopupMenuItem(

                                    value:"done",

                                    child:
                                    Text(
                                      "Tandai Selesai",
                                    ),

                                  ),





                                const PopupMenuItem(

                                  value:"delete",

                                  child:
                                  Text(
                                    "Hapus",
                                  ),

                                ),



                              ];



                            },





                            onSelected:
                                (value) async {



                              if(value=="edit"){



                                await Navigator.push(



                                  context,

                                  MaterialPageRoute(



                                    builder: (_)=>
                                    EditEventPage(

                                      event:event,

                                    ),



                                  ),



                                );



                                loadEvents();



                              }





                              if(value=="done"){



                                setDone(event);



                              }







                              if(value=="delete"){



                                deleteEvent(event);



                              }



                            },



                          ),



                        ),



                      );



                    },



                  ),



                ),



              ],



            ),



          ),



        ],



      ),




    );


  }


}