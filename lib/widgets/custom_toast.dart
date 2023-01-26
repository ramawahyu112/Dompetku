import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<bool?> customToast(String msg, 
    [Color bgColor = Colors.grey, Color? txtColor = Colors.black]){
  return Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: bgColor,
        textColor: txtColor,
        fontSize: 16.0
  );
}