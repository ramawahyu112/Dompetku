
import 'package:flutter/cupertino.dart';
import 'package:mydompet/pages/bottom_navigation.dart';
import 'package:mydompet/pages/home/home_form_page.dart';
import 'package:mydompet/pages/home/home_page.dart';

class Routes {

   static final paths = <String, WidgetBuilder> {
    HomePage.routeName : (context) => const HomePage(),
    HomeFormPage.routeName : (context) => const HomeFormPage(),
    BottomNavigation.routeName : (context) => const BottomNavigation(),
   };
}