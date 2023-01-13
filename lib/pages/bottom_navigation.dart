import 'package:flutter/material.dart';
import 'package:mydompet/pages/home/cash_page.dart';
import 'package:mydompet/pages/home/home_page.dart';
import 'package:mydompet/providers/balance_provider.dart';
import 'package:mydompet/utils/color.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

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

  List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
          PersistentBottomNavBarItem(
              icon: const Icon(Icons.home),
              title: ("Home"),
              activeColorPrimary: bottomNavActive,
              inactiveColorPrimary: bottomNavInactive,
          ),
          PersistentBottomNavBarItem(
              icon: const Icon(Icons.shopping_bag),
              title: ("Cash"),
              activeColorPrimary: bottomNavActive,
              inactiveColorPrimary: bottomNavInactive,
          ),     PersistentBottomNavBarItem(
              icon: const Icon(Icons.abc),
              title: ("Test"),
              activeColorPrimary: bottomNavActive,
              inactiveColorPrimary: bottomNavInactive,
          ),     PersistentBottomNavBarItem(
              icon: const Icon(Icons.money),
              title: ("Settings"),
              activeColorPrimary: bottomNavActive,
              inactiveColorPrimary: bottomNavInactive,
          ),     PersistentBottomNavBarItem(
              icon: const Icon(Icons.money),
              title: ("Settings"),
              activeColorPrimary: bottomNavActive,
              inactiveColorPrimary: bottomNavInactive,
          ),
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
        onPressed: () {
          provider.setBalanceAmount = "1000000";
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}