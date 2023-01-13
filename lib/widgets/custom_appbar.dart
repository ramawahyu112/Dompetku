import 'package:flutter/material.dart';
import 'package:mydompet/utils/style.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final bool canBack;

  const CustomAppBar({
    super.key,
    this.title = "", 
    this.canBack = false
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
  
  @override
  Size get preferredSize {
    return const Size.fromHeight(kToolbarHeight);
  }
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(widget.title, style: appBarTitle),
      centerTitle: true,
      automaticallyImplyLeading: widget.canBack ? true : false,

    );
  }
}