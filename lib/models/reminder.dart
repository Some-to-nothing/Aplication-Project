class Reminder {


  final int? id;

  final String title;

  final String time;

  final bool isActive;



  Reminder({

    this.id,

    required this.title,

    required this.time,

    required this.isActive,

  });



  Map<String,dynamic> toMap(){

    return {

      "id": id,

      "title": title,

      "time": time,

      "isActive": isActive ? 1 : 0,

    };

  }



  factory Reminder.fromMap(Map<String,dynamic> map){

    return Reminder(

      id: map["id"],

      title: map["title"],

      time: map["time"],

      isActive: map["isActive"] == 1,

    );

  }


}