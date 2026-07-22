import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/event_model.dart';

class DBHelper {
  static Database? _database;

  static Future<Database> getDatabase() async {
    if (_database != null) {
      return _database!;
    }

    _database = await openDatabase(
      join(await getDatabasesPath(), "prokelom.db"),
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE events(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT NOT NULL,
          note TEXT,
          date TEXT NOT NULL,
          time TEXT NOT NULL
        )
        ''');
      },
    );

    return _database!;
  }

  // ==========================
  // INSERT
  // ==========================

  static Future<int> insert(EventModel event) async {
    final db = await getDatabase();

    return await db.insert(
      "events",
      event.toMap(),
    );
  }

  // ==========================
  // GET ALL
  // ==========================

  static Future<List<EventModel>> getEvents() async {
    final db = await getDatabase();

    final List<Map<String, dynamic>> maps = await db.query(
      "events",
      orderBy: "date ASC, time ASC",
    );

    return List.generate(
      maps.length,
      (i) => EventModel.fromMap(maps[i]),
    );
  }

  // ==========================
  // GET BY ID
  // ==========================

  static Future<EventModel?> getEventById(int id) async {
    final db = await getDatabase();

    final result = await db.query(
      "events",
      where: "id=?",
      whereArgs: [id],
    );

    if (result.isEmpty) {
      return null;
    }

    return EventModel.fromMap(result.first);
  }

  // ==========================
  // UPDATE
  // ==========================

  static Future<int> update(EventModel event) async {
    final db = await getDatabase();

    return await db.update(
      "events",
      event.toMap(),
      where: "id=?",
      whereArgs: [event.id],
    );
  }

  // ==========================
  // DELETE
  // ==========================

  static Future<int> delete(int id) async {
    final db = await getDatabase();

    return await db.delete(
      "events",
      where: "id=?",
      whereArgs: [id],
    );
  }

  // ==========================
  // DELETE ALL
  // ==========================

  static Future<void> deleteAll() async {
    final db = await getDatabase();

    await db.delete("events");
  }
}