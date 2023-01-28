import '../database/databases_column.dart';

class CashModel{
   int? id;
   String title, date;
   double price;
   int cashType;

  CashModel({
    this.id, 
    required this.title, 
    required this.price, 
    required this.date,
    required this.cashType,
  });

  Map<String, dynamic> toMap() {
    var map = <String, Object?>{
      columnTitle:title,
      columnPrice: price,
      columnDate: date,
      columnCashType: cashType
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
    cashType: map[columnCashType],
  );

}

