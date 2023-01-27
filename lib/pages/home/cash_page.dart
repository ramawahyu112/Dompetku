import 'package:flutter/material.dart';

class CashPage extends StatefulWidget {
  static const routeName = '/cashpage';
  const CashPage({super.key});

  @override
  State<CashPage> createState() => _CashPageState();
}

class _CashPageState extends State<CashPage> {
  @override
  Widget build(BuildContext context) {
    return const Text('cash');
  }
}