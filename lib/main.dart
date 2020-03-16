import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            backgroundColor: Colors.pink,
            body: SafeArea(
                child: Container(
                    padding: EdgeInsets.only(left: 10, top: 40, right: 10),
                    child: Column()))));
  }
}
