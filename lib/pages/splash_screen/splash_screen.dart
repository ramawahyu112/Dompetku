import 'package:flutter/material.dart';
import 'package:mydompet/pages/bottom_navigation.dart';
import 'package:mydompet/utils/asset.dart';
import 'package:mydompet/utils/sizeconfig.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/splashScreen';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3)).then((value) {
      Navigator.pushNamed(context, BottomNavigation.routeName);
    });
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: SizeConfig(context).parentHeight(100),
      width: SizeConfig(context).parentWidth(100),
      alignment: Alignment.center,
      child: Center(
        child: Image.asset(SPLASH_LOGO)
      ),
    );
  }
}