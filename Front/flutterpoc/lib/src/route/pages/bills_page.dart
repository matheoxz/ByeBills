import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterpoc/src/view/bills_list.dart';

class BillsListPage extends Page {
  final Function() onNewBill;
  final Function() onConfigurations;
  final Function(int id) onSelect;

  BillsListPage(
      {required this.onNewBill,
      required this.onConfigurations,
      required this.onSelect});
  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
        settings: this,
        builder: (context) => BillsList(
              onNewBill: onNewBill,
              onConfigurations: onConfigurations,
              onSelect: onSelect,
            ));
  }
}
