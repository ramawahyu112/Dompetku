
import 'package:flutter/material.dart';
import 'package:mydompet/pages/bottom_navigation.dart';
import 'package:mydompet/pages/home/home_form_page.dart';
import 'package:mydompet/pages/home/home_page.dart';
import 'package:mydompet/pages/splash_screen/splash_screen.dart';

  Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case SplashScreen.routeName:
          return MaterialPageRoute(builder: (_) => const SplashScreen());
      case HomePage.routeName:
          return MaterialPageRoute(builder: (_) => const HomePage());
      case HomeFormPage.routeName:
          return MaterialPageRoute(builder: (_) => const HomeFormPage());
      case BottomNavigation.routeName:
          return MaterialPageRoute(builder: (_) => const BottomNavigation());
      default:
          return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
  }