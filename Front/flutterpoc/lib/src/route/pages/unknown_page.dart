import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterpoc/src/view/unknown.dart';

class UnknownPage extends Page {
  final Function() backToHome;
  UnknownPage({required this.backToHome});
  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (context) => Unknown(
        backToHome: backToHome,
      ),
    );
  }
}
