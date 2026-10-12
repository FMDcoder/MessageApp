import 'package:flutter/material.dart';
import 'component/header.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  final int secret = 10;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: MyAppBar(title: 'Home'),
        body: const Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}