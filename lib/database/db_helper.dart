import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/event_model.dart';


class DBHelper {


  static Database? _database;




  static Future<Database> getDatabase() async {


    if(_database != null){

      return _database!;

    }



    _database = await openDatabase(


      join(
        await getDatabasesPath(),
        "remindus.db",
      ),



      version: 2,



      onCreate: (db, version) async {



        await db.execute('''

        CREATE TABLE events(

          id INTEGER PRIMARY KEY AUTOINCREMENT,

          title TEXT NOT NULL,

          note TEXT,

          date TEXT NOT NULL,

          time TEXT NOT NULL,

          status TEXT NOT NULL DEFAULT 'pending'

        )

        ''');



      },







      // ==========================
      // UPDATE DATABASE
      // ==========================


      onUpgrade:
          (db, oldVersion, newVersion) async {



        if(oldVersion < 2){



          await db.execute('''

          ALTER TABLE events

          ADD COLUMN status TEXT NOT NULL DEFAULT 'pending'

          ''');



        }



      },



    );



    return _database!;


  }







  // ==========================
  // INSERT
  // ==========================


  static Future<int> insert(
      EventModel event
      ) async {


    final db =
    await getDatabase();



    return await db.insert(

      "events",

      event.toMap(),

    );


  }









  // ==========================
  // GET ALL
  // ==========================


  static Future<List<EventModel>> getEvents() async {


    final db =
    await getDatabase();



    final data =
    await db.query(

      "events",

      orderBy:
      "date ASC, time ASC",

    );



    return data.map(

          (e)=>
          EventModel.fromMap(e),

    ).toList();



  }









  // ==========================
  // UPDATE
  // ==========================


  static Future<int> update(
      EventModel event
      ) async {


    final db =
    await getDatabase();



    return await db.update(


      "events",


      event.toMap(),


      where:
      "id=?",


      whereArgs:
      [event.id],


    );


  }









  // ==========================
  // UPDATE STATUS
  // ==========================


  static Future<int> updateStatus(
      int id,
      String status,
      ) async {


    final db =
    await getDatabase();



    return await db.update(


      "events",


      {


        "status":
        status,


      },



      where:
      "id=?",



      whereArgs:
      [id],



    );


  }









  // ==========================
  // DELETE USER MANUAL
  // ==========================


  static Future<int> delete(
      int id
      ) async {


    final db =
    await getDatabase();



    return await db.delete(


      "events",


      where:
      "id=?",



      whereArgs:
      [id],



    );


  }





}