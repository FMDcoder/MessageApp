import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({
    super.key,
    required this.title,
    this.actions,
  });

  final String title;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      foregroundColor: Color.fromRGBO(0xF5, 0xF5, 0xF5, 1.0),
      backgroundColor: Color.fromRGBO(0x47, 0x9A, 0x36, 1.0),
      actions: actions,
      titleTextStyle: const TextStyle(
        fontFamily: 'Roboto',
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  // Tells Scaffold how tall the bar is
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}