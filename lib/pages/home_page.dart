import 'package:flutter/material.dart';

import 'add_reminder_page.dart';
import '../database/database_helper.dart';
import '../models/reminder.dart';



class HomePage extends StatefulWidget {


const HomePage({super.key});



@override
State<HomePage> createState()
=> _HomePageState();


}




class _HomePageState
extends State<HomePage>{



List<Reminder> reminders=[];



@override
void initState(){

super.initState();

loadData();

}





Future<void> loadData() async {


final data =
await DatabaseHelper.instance.getAll();



setState((){

reminders=data;

});


}






@override
Widget build(BuildContext context){



return Scaffold(


appBar:AppBar(

title:
const Text("🌤 Sky Reminder"),

),



floatingActionButton:
FloatingActionButton.extended(


icon:
const Icon(Icons.add_alarm),



label:
const Text("Tambah"),



onPressed:() async {


final result = await Navigator.push(

context,

MaterialPageRoute(

builder:(context)
=> const AddReminderPage()

)

);



if(result == true){

loadData();

}



},


),




body:ListView.builder(


padding:
const EdgeInsets.all(20),



itemCount:
reminders.length,



itemBuilder:(context,index){


final item =
reminders[index];



return Card(


child:ListTile(


leading:
const Icon(Icons.alarm),



title:
Text(item.title),



subtitle:
Text(item.time),



),


);



}


),



);


}


}