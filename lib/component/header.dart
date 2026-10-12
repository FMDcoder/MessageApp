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
      backgroundColor: Colors.teal,
      actions: actions,
    );
  }

  // Tells Scaffold how tall the bar is
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}