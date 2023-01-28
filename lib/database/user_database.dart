import 'package:mydompet/database/databases.dart';
import 'package:sqflite/sqflite.dart';

import '../models/user_model.dart';
import 'databases_column.dart';

class CashDatabase {
  final base = Databases();
  
  Future<List<UserModel>> select() async {
    Database? db = await base.database;
    var mapList = await db!.query(tableUser, orderBy: columnId);
    var userList = List<UserModel>.from(mapList.map((x) => UserModel.fromMap(x)));
    return userList;
   }

   Future<UserModel> insert(UserModel user) async {
    Database? db = await base.database;
    user.id = await db!.insert(tableUser, user.toMap());
    return user;
   }

   Future<int> update(UserModel user) async {
    Database? db = await base.database;
    return await db!.update(tableUser, user.toMap(),
        where: '$columnId = ?', 
        whereArgs: [user.id]);
   }
  
}