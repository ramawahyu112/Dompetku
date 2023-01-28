
import 'package:sqflite/sqflite.dart';
import '../models/cash_model.dart';
import '../database/databases.dart';
import 'databases_column.dart';

class CashDatabase {
  final base = Databases();
  Future<List<CashModel>> select() async {
    Database? db = await base.database;
    var mapList = await db!.query(tableCash, orderBy: columnId);
    var casList = List<CashModel>.from(mapList.map((x) => CashModel.fromMap(x)));
    return casList;
   }

   Future<CashModel> insert(CashModel cash) async {
    Database? db = await base.database;
    cash.id = await db!.insert(tableCash, cash.toMap());
    return cash;
   }

   Future<CashModel?> getCash(int id) async {
    Database? db = await base.database;
    List<Map> maps = await db!.query(tableCash, 
        columns: [
          columnId, 
          columnTitle, 
          columnPrice, 
          columnDate,
          columnCashType],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return CashModel.fromMap(maps.first);
    }
    return null;
   }

   Future<int> delete(int id) async {
    Database? db = await base.database;
    return await db!.delete(tableCash, 
        where: '$columnId = ?', 
        whereArgs: [id]);
   }

   Future<int> update(CashModel cash) async {
    Database? db = await base.database;
    return await db!.update(tableCash, cash.toMap(),
        where: '$columnId = ?', 
        whereArgs: [cash.id]);
   }

  
}