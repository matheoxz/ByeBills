import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterpoc/src/view/bill_detail.dart';

class BillDetailPage extends Page {
  final int billId;
  final Function() onBack;

  BillDetailPage({required this.billId, required this.onBack});
  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
        settings: this,
        builder: (context) => BillDetail(
              billId: billId,
              onBack: onBack,
            ));
  }
}
