import 'package:flutter/material.dart';
import 'package:mydompet/pages/home/cash_page.dart';
import 'package:mydompet/pages/home/home_page.dart';
import 'package:mydompet/providers/balance_provider.dart';
import 'package:mydompet/utils/color.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

import 'home/home_form_page.dart';

class BottomNavigation extends StatefulWidget {
  static const String routeName = '/bottomNavigation';
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  late PersistentTabController _controller;
  List<Widget> _listWidget() {
    return [
      const HomePage(),
      const CashPage(),
      const CashPage(),
      const CashPage(),
      const CashPage(),

    ];
  }

  PersistentBottomNavBarItem barItem(IconData icon, String title, [Color? color] ) {
    return  PersistentBottomNavBarItem(
        icon: Icon(icon, color: color),
        title: title,
        activeColorPrimary: bottomNavActive,
        inactiveColorPrimary: bottomNavInactive,
      );
  } 

  List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
          barItem(Icons.home, "Home"),
          barItem(Icons.shopping_bag, "Cash"),
          barItem(Icons.attach_money, "Pay", Colors.white),
          barItem(Icons.list_alt, "History"),
          barItem(Icons.settings, "Setting"),
      ];
  }
  @override
  void initState() {
    _controller = PersistentTabController(initialIndex: 0);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final provider = context.read<BalanceProvider>();
    return PersistentTabView(context, 
      screens: _listWidget(),
      controller: _controller,
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white,
      handleAndroidBackButtonPress: true, 
      resizeToAvoidBottomInset: false,
      stateManagement: true, 
      hideNavigationBarWhenKeyboardShows: true, 
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties( 
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation( 
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style15,
      floatingActionButton: FloatingActionButton(
        backgroundColor: bottomNavActive,
        onPressed: () {
          provider.setBalanceAmount = "1000000";
          Navigator.pushNamed(context, HomeFormPage.routeName);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}