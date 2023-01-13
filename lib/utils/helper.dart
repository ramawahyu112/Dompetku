


import 'package:flutter/material.dart';
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

