import '../database/databases_column.dart';

class UserModel{
   int? id;
   String name;
   double balance;

  UserModel({
    this.id, 
    required this.name, 
    required this.balance, 
  });

  Map<String, dynamic> toMap() {
    var map = <String, Object?>{
      columnName: name,
      columnBalance: balance,
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

 factory UserModel.fromMap(Map<dynamic, dynamic> map) => UserModel(
    id: map[columnId], 
    name: map[columnName],
    balance: map[columnBalance], 
  );

}
