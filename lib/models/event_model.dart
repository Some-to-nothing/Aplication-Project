class EventModel {

  int? id;

  String title;
  String note;
  String date;
  String time;


  EventModel({

    this.id,

    required this.title,
    required this.note,
    required this.date,
    required this.time,

  });



  Map<String,dynamic> toMap(){

    return {

      'id':id,

      'title':title,

      'note':note,

      'date':date,

      'time':time,

    };

  }



  factory EventModel.fromMap(Map<String,dynamic> map){

    return EventModel(

      id: map['id'],

      title: map['title'],

      note: map['note'],

      date: map['date'],

      time: map['time'],

    );

  }


}