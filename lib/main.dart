import 'package:flutter/material.dart';
import 'package:mydompet/pages/splash_screen/splash_screen.dart';
import 'package:mydompet/providers/balance_provider.dart';
import 'package:mydompet/providers/cash_provider.dart';
import 'package:mydompet/route.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BalanceProvider>(
            create: (context) => BalanceProvider()),
        ChangeNotifierProvider<CashProvider>(
            create: (context) => CashProvider()..getAllData()),
      ],
      builder: (context, child) => MaterialApp(
          theme: ThemeData(
            primaryColor: Colors.white54
          ),
          routes: Routes.paths,
          home: const SplashScreen(),
          debugShowCheckedModeBanner: false,
        ),
    );
  }
}


