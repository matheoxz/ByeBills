import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterpoc/src/view/new_bill.dart';

class NewBillPage extends Page {
  final Function() onBack;

  NewBillPage({required this.onBack});
  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
        settings: this,
        builder: (context) => NewBill(
              onBack: onBack,
            ));
  }
}
