import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/reminder.dart';



class DatabaseHelper {


  static final DatabaseHelper instance =
      DatabaseHelper._init();



  static Database? _database;



  DatabaseHelper._init();



  Future<Database> get database async {


    if(_database != null){

      return _database!;

    }


    _database = await initDB();


    return _database!;


  }





  Future<Database> initDB() async {


    final path = join(

      await getDatabasesPath(),

      "reminder.db"

    );



    return await openDatabase(

      path,

      version:1,


      onCreate:(db,version){


        return db.execute('''

        CREATE TABLE reminders(

          id INTEGER PRIMARY KEY AUTOINCREMENT,

          title TEXT,

          time TEXT,

          isActive INTEGER

        )

        ''');


      }


    );


  }






  Future<int> insert(Reminder reminder) async {


final db = await instance.database;


final result = await db.insert(

"reminders",

reminder.toMap()

);



print("DATA MASUK ID : $result");


return result;


}






  Future<List<Reminder>> getAll() async {


    final db = await instance.database;


    final data = await db.query(

      "reminders",

    );



    return data

    .map(

      (e)=>Reminder.fromMap(e)

    )

    .toList();


  }






  Future<int> delete(int id) async {


    final db = await instance.database;


    return await db.delete(

      "reminders",

      where:"id=?",

      whereArgs:[id]

    );


  }


}