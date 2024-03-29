import 'package:flutter/cupertino.dart';

import '../database/cash_database.dart';
import '../models/cash_model.dart';

class CashProvider with ChangeNotifier {
  List<CashModel>? _cashList;
  int? _idCash;
  int? _cashType;
  double? _balanceAmount;
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
  
  set setIdCash(val) {
    _idCash = val;
    notifyListeners();
  }

  set setCashType(val) {
    _cashType = val;
    notifyListeners();
  }

  set setBalance(val) {
    _balanceAmount = val;
    notifyListeners();
  }

  set addBalance(val) {
    _balanceAmount = (_balanceAmount ?? 0.0) + val;
    notifyListeners();
  }

  set subtractBalance(val) {
    _balanceAmount = (_balanceAmount ?? 0.0) - val;
    notifyListeners();
  }

  List<CashModel>? get cashList => _cashList;
  int? get idCash => _idCash;
  int? get cashType => _cashType;
  double? get balanceAmount => _balanceAmount;
  TextEditingController get activityController => _activityController;
  TextEditingController get priceController => _priceController;
  TextEditingController get dateController => _dateController;

  clearController() {
    setIdCash = null;
    _activityController.clear();
    _priceController.clear();
    _dateController.clear();
    _cashType = null;
  }

  getAllData() async {
    setCash = await database.select();
    var balance = (balanceAmount ?? 0.0) 
          + _cashList!.fold(0.0, (pV, cV) => pV + cV.price);
    setBalance = balance;
  }

 Future<CashModel> insertCash() async {
    var cashModel = fetchToModel();
    var result = await database.insert(cashModel);
    addCash = result;
    addBalance = result.price;
    return result;
  }

  Future<int> updateCash() async {
    var cashModel = fetchToModel();
    var result = await database.update(cashModel);
    getAllData();
    return result;
  }

  Future<int> deleteCash() async {
    var result = await database.delete(_idCash!);
    if (result == 1) {
      var model =  _cashList!.firstWhere((element) => element.id == idCash);
      subtractBalance = model.price;
      _cashList!.removeWhere((element) => element.id == idCash);
    }
    clearController();
    notifyListeners();
    return result;
  }

  CashModel fetchToModel() {
    CashModel cashModel = CashModel(
      id: _idCash,
      title: activityController.text, 
      price: double.parse(priceController.text), 
      date: dateController.text,
      cashType: _cashType!
    );
    if (cashModel.cashType == 0) {
      cashModel.price = cashModel.price.abs();
    } else if (cashModel.cashType == 1) {
      if (!cashModel.price.isNegative) {
        cashModel.price = cashModel.price * -1;
      }
    }
    return cashModel;
  }

  void fetchToController() async {
    var model = await database.getCash(idCash!);
    _activityController.text = model?.title ?? "";
    _dateController.text = model?.date ?? "";
    _priceController.text = model?.price.toString() ?? "";
    _cashType = model?.cashType;
    notifyListeners();
  }

}