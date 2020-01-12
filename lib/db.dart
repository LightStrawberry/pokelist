import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart';

class DBManager {
  static const VERSION = 1;
  static const DB_NAME = "pokedex.db";
  static Database _database;

  static init() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "pokedex.db");

    // Check if the database exists
    var exists = await databaseExists(path);

    if (!exists) {
      // Should happen only the first time you launch your application
      print("Creating new copy from asset");

      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}
        
      // Copy from asset
      ByteData data = await rootBundle.load(join("databases", "pokedex.db"));
      List<int> bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      
      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);

    } else {
      print("Opening existing database");
    }
    // open the database
    _database = await openDatabase(path, readOnly: true);
    // // print(await db.query('sqlite_master', columns: ['name']));
    // List<Map> list = await db.rawQuery('select * from pokemon');
    // print(list);
  }

  static Future<Database> getDatabase() async {
    if (_database == null) {
      await init();
    }
    return _database;
  }

  Future<List<Map>> query(String sql) async {
    Database database = await getDatabase();
    List<Map<String, dynamic>> result = await database.rawQuery('select * from pokemon');
    // var list = List<User>();
    // if (result.length > 0) {
    //   for (int i = 0; i < result.length; i++) {
    //     Map<String, dynamic> it = result[i];
    //     User user = User.fromJson(it);
    //     list.add(user);
    //   }
    // }
    return result;
  }
}