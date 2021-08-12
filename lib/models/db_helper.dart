import 'dart:io';
import 'package:exam/models/task.dart';
import 'package:exam/models/user.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:synchronized/synchronized.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static Database? _database;

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._internal();
      return _databaseHelper!;
    } else {
      return _databaseHelper!;
    }
  }
  DatabaseHelper._internal();

  Future<Database> _getDatabase() async {
    if (_database == null) {
      _database = await _initialDatabase();
      return _database!;
    } else {
      return _database!;
    }
  }

  Future _initialDatabase() async {
    var lock = Lock();
    Database? _db;

    if (_db == null) {
      await lock.synchronized(() async {
        if (_db == null) {
          var databasesPath = await getDatabasesPath();
          String path = join(databasesPath, 'database.db');
          // print("DB`ning PATHi: " + path.toString());
          var file = File(path);
          // path -> /Users/zemeister/Desktop/flutter/44dars/assets/kategoriya.db
          if (!await file.exists()) {
            ByteData data =
                await rootBundle.load(join("assets", "database.db"));
            List<int> bytes =
                data.buffer.asInt8List(data.offsetInBytes, data.lengthInBytes);
            await File(path).writeAsBytes(bytes);
          }
          _db = await openDatabase(path);
        }
      });
    }
    return _db;
  }

  Future<List<Map<String, dynamic>>> fetchDatas() async {
    var db = await _getDatabase();
    var result = await db.query("tasks");
    return result;
  }
  Future<int> taskAdd(TaskClass t) async {
    var db = await _getDatabase();
    var result = await db.insert("tasks", t.toMap());
    return result;
  }

  Future<int> taskDelete(int tID) async {
    var db = await _getDatabase();
    var result = await db
        .delete("tasks", where: 'taskID = ?', whereArgs: [tID]);
    return result;
  }

  // user add
  Future<int> userAdd(Account u) async {
    var db = await _getDatabase();
    var result = await db.insert("user", u.toMap());
    return result;
  }
  Future<List<Map<String, dynamic>>> fetchUser() async {
    var db = await _getDatabase();
    var result = await db.query("user");
    return result;
  }
}
