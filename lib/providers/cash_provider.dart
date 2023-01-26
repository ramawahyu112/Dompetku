import 'package:flutter/cupertino.dart';

import '../models/cash_model.dart';

class CashProvider with ChangeNotifier {
  List<CashModel>? _cashList;
  final database = CashDatabase();

  final TextEditingController _activityController = TextEditingController();
  final TextEditingController _priceController= TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  set addCash(val) {
    _cashList!.add(val);
    notifyListeners();
  }

  set setCash(val) {
    _cashList = val;
    notifyListeners();
  }

  List<CashModel>? get cashList => _cashList;
  TextEditingController get activityController => _activityController;
  TextEditingController get priceController => _priceController;
  TextEditingController get dateController => _dateController;

  clearController() {
    _activityController.clear();
    _priceController.clear();
    _dateController.clear();
  }

  getAllData() async {
    setCash = await database.select();
  }

 Future<CashModel> insertCash() async {
    CashModel cashModel = CashModel(
      title: activityController.text, 
      price: double.parse(priceController.text), 
      date: dateController.text
    );
   var result = await database.insert(cashModel);
   addCash = result;
   return result;
  }


}