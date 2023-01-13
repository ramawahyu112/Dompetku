import 'package:flutter/material.dart';
import 'package:mydompet/pages/bottom_navigation.dart';
import 'package:mydompet/utils/asset.dart';
import 'package:mydompet/utils/helper.dart';
import 'package:mydompet/utils/sizeconfig.dart';
import 'package:mydompet/utils/style.dart';

class SplashScreen extends StatefulWidget {
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(SPLASH_LOGO),
          verticalSpaceMD(),
          Text("Dompetku", style: splashText)
        ],
      ),
    );
  }
}