import 'package:flutter/material.dart';
import 'package:flutterpoc/src/view/login.dart';
import 'package:flutterpoc/src/view/new_bill.dart';
import 'package:flutterpoc/src/view/signup.dart';
import 'package:flutterpoc/src/view/unknown.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ByeBills',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'ByeBills'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return UnknownPage();
  }
}
