import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterpoc/src/view/configurations.dart';

class ConfigurationsPage extends Page {
  final Function() onBack;
  final Function() onLogOut;
  final Function() onDeleteAccount;

  ConfigurationsPage({
    required this.onBack,
    required this.onLogOut,
    required this.onDeleteAccount,
  });

  @override
  Route createRoute(BuildContext context) {
    // TODO: implement createRoute
    return MaterialPageRoute(
      settings: this,
      builder: (context) => ConfigurationsPageView(
          onBack: onBack, onLogOut: onLogOut, onDeleteAccount: onDeleteAccount),
    );
  }
}
