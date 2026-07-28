class EventModel {


  int? id;


  String title;


  String note;


  String date;


  String time;


  String status;



  EventModel({

    this.id,

    required this.title,

    required this.note,

    required this.date,

    required this.time,

    this.status = "pending",

  });







  // ==========================
  // TO MAP DATABASE
  // ==========================


  Map<String, dynamic> toMap(){


    return {


      'id': id,


      'title': title,


      'note': note,


      'date': date,


      'time': time,


      'status': status,


    };


  }








  // ==========================
  // FROM DATABASE
  // ==========================


  factory EventModel.fromMap(
      Map<String,dynamic> map
      ){


    return EventModel(


      id: map['id'],


      title: map['title'] ?? "",


      note: map['note'] ?? "",


      date: map['date'] ?? "",


      time: map['time'] ?? "",



      // kalau data lama belum punya status
      // otomatis jadi pending

      status:
      map['status'] ?? "pending",


    );


  }








  // ==========================
  // COPY WITH
  // nanti dipakai update status
  // ==========================


  EventModel copyWith({


    int? id,


    String? title,


    String? note,


    String? date,


    String? time,


    String? status,


  }){


    return EventModel(


      id:
      id ?? this.id,


      title:
      title ?? this.title,


      note:
      note ?? this.note,


      date:
      date ?? this.date,


      time:
      time ?? this.time,


      status:
      status ?? this.status,


    );


  }



}