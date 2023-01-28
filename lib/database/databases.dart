import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'databases_column.dart';

class Databases {
   static Database? _db;
   static Databases? _databases;
   Databases._createObject();

    factory Databases() {
        _databases ??= Databases._createObject();
      return _databases!;
    }

   Future<Database> openDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}cash.db';

    var db = await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''create table $tableCash (
        $columnId integer primary key autoincrement, 
        $columnTitle text not null, 
        $columnPrice real not null,
        $columnDate text not null,
        $columnCashType integer not null)
      ''');

      await db.execute('''create table $tableUser (
        $columnId integer primary key autoincrement, 
        $columnName text not null,
        $columnBalance real not null)
      ''');
    });
    return db;
   }

   Future<Database?> get database async {
    _db ??= await openDB();
    return _db;
   }
   
   Future close() async => _db!.close();
   
}