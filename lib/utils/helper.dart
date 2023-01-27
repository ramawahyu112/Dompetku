


import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mydompet/utils/dimen.dart';


// Spacing
Widget spacing({double height = 0, double width = 0}){
  return SizedBox(height: height, width: width);
}

//Spacing Vertical
Widget verticalSpaceSM(){
  return spacing(height: sizeSmall);
}

Widget verticalSpaceMD(){
    return spacing(height: sizeMedium);
}

Widget verticalSpaceLG(){
    return spacing(height: sizeLarge);
}

dynamic formatCurrency(dynamic number) {
  if (number != null) {
    NumberFormat format = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp',
      decimalDigits: 2,    
    );
    return format.format(number);
  }
  return "0.0";
}

