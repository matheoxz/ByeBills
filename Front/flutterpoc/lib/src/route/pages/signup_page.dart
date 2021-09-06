import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterpoc/src/view/signup.dart';

class SignUpPage extends Page {
  final Function() onPop;
  SignUpPage({required this.onPop});
  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
        settings: this,
        builder: (context) => SignUp(
              onPop: onPop,
            ));
  }
}
