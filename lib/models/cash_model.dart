import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

const String tableCash = 'cashflow';
const String columnId = 'id';
const String columnTitle = 'title';
const String columnPrice = 'price';
const String columnDate = 'date';

class CashModel{
   int? id;
   String title, date;
   double price;

  CashModel({
    this.id, 
    required this.title, 
    required this.price, 
    required this.date
  });

  Map<String, dynamic> toMap() {
    var map = <String, Object?>{
      columnTitle:title,
      columnPrice: price,
      columnDate: date,
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

 factory CashModel.fromMap(Map<dynamic, dynamic> map) => CashModel(
    id: map[columnId], 
    title: map[columnTitle],
    price: map[columnPrice], 
    date: map[columnDate],
  );

}

class CashDatabase {
   static Database? _db;
   static CashDatabase? _cashDatabase;
   CashDatabase._createObject();

    factory CashDatabase() {
        _cashDatabase ??= CashDatabase._createObject();
      return _cashDatabase!;
    }

   Future<Database> openDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}cash.db';

    var db = await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''create table $tableCash (
        $columnId integer primary key autoincrement, 
        $columnTitle text not null, 
        $columnPrice real not null,
        $columnDate text not null)
      ''');
    });
    return db;
   }

   Future<Database?> get database async {
    _db ??= await openDB();
    return _db;
   }

   Future<List<CashModel>> select() async {
    Database? db = await database;
    var mapList = await db!.query(tableCash, orderBy: columnId);
    var casList = List<CashModel>.from(mapList.map((x) => CashModel.fromMap(x)));
    return casList;
   }

   Future<CashModel> insert(CashModel cash) async {
    Database? db = await database;
    cash.id = await db!.insert(tableCash, cash.toMap());
    return cash;
   }

   Future<CashModel?> getCash(int id) async {
    Database? db = await database;
    List<Map> maps = await db!.query(tableCash, 
        columns: [
          columnId, 
          columnTitle, 
          columnPrice, 
          columnDate],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return CashModel.fromMap(maps.first);
    }
    return null;
   }

   Future<int> delete(int id) async {
    Database? db = await database;
    return await db!.delete(tableCash, 
        where: '$columnId = ?', 
        whereArgs: [id]);
   }

   Future<int> update(CashModel cash) async {
    Database? db = await database;
    return await db!.update(tableCash, cash.toMap(),
        where: '$columnId = ?', 
        whereArgs: [cash.id]);
   }

   Future close() async => _db!.close();
   
}