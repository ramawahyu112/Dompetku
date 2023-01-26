import 'package:flutter/cupertino.dart';
import 'package:mydompet/models/cash_model.dart';

class BalanceProvider with ChangeNotifier {
  String _balanceAmount = "0";

  set setBalanceAmount(val) {
    _balanceAmount = val;
    notifyListeners();
  }

  String get balanceAmount => _balanceAmount;
}