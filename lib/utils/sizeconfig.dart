import 'package:flutter/material.dart';

class SizeConfig{
  late BuildContext _context;
  late double height;
  late double width;


  SizeConfig(context) {
    _context = context;
    MediaQueryData queryData = MediaQuery.of(context);
    height = queryData.size.height / 100;
    width = queryData.size.width / 100;
  }

  double parentHeight(double size) {
    return height * size;
  }

  double parentWidth(double size) {
    return width * size;
  }

}