import 'package:flutter/material.dart';
import 'package:flutterpoc/config/get_it_registrations.dart';

import 'config/configure_nonweb.dart'
    if (dart.library.html) 'config/configure_web.dart';
import 'package:flutterpoc/src/route/router_delegate.dart';
import 'package:flutterpoc/src/route/router_parser.dart';

final String url = 'localhost:44305';
void main() async {
  setupGetIt();
  configureApp();
  runApp(ByeBills());
}

class ByeBills extends StatefulWidget {
  ByeBills({Key? key}) : super(key: key);

  @override
  _ByeBillsState createState() => _ByeBillsState();
}

class _ByeBillsState extends State<ByeBills> {
  late BillRouteParser routeParser;
  late BillsRouterDelegate routerDelegate;

  @override
  void initState() {
    routeParser = BillRouteParser();
    routerDelegate = BillsRouterDelegate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: "ByeBills",
        routeInformationParser: routeParser,
        routerDelegate: routerDelegate);
  }
}
