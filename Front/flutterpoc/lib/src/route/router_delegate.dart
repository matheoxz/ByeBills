import 'package:flutter/material.dart';
import 'package:flutterpoc/src/route/pages/bill_detail_page.dart';
import 'package:flutterpoc/src/route/pages/bills_page.dart';
import 'package:flutterpoc/src/route/pages/login_page.dart';
import 'package:flutterpoc/src/route/pages/new_bill_page.dart';
import 'package:flutterpoc/src/route/pages/signup_page.dart';
import 'package:flutterpoc/src/route/pages/unknown_page.dart';

import 'app_configuration.dart';

class BillsRouterDelegate extends RouterDelegate<MyAppConfiguration>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<MyAppConfiguration> {
  //variables to the routing
  late bool _show404;
  bool get show404 => _show404;
  set show404(bool value) {
    _show404 = value;

    notifyListeners();
  }

  late bool _loggedIn = false;
  bool get loggedIn => _loggedIn;
  set loggedIn(value) {
    //logout
    if (_loggedIn == true && value == false) _clear();
    _loggedIn = value;
    notifyListeners();
  }

  late bool _signup;
  bool get signup => _signup;
  set signup(bool value) {
    _signup = value;
    notifyListeners();
  }

  late bool _configurations;
  bool get configurations => _configurations;
  set configurations(value) {
    _configurations = value;
    notifyListeners();
  }

  int? _selectedBillId;
  int? get selectedBillId => _selectedBillId;
  set selectedBillId(int? value) {
    _selectedBillId = value;
    //check if is valid
    notifyListeners();
  }

  late bool _newBill = false;
  bool get newBill => _newBill;
  set newBill(bool value) {
    _newBill = value;
    notifyListeners();
  }

  _clear() {
    _show404 = false;
    _signup = false;
    _configurations = false;
    _selectedBillId = null;
    _newBill = false;
  }

  late GlobalKey<NavigatorState> _navigatorKey;

  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  BillsRouterDelegate() : _navigatorKey = GlobalKey<NavigatorState>() {
    _clear();
  }

  @override
  MyAppConfiguration get currentConfiguration {
    if (show404)
      return MyAppConfiguration.unknown();
    else if (!loggedIn && !signup)
      return MyAppConfiguration.login();
    else if (!loggedIn && signup)
      return MyAppConfiguration.signup();
    else if (loggedIn) {
      if (selectedBillId == null && !newBill && !configurations)
        return MyAppConfiguration.bills();
      else if (selectedBillId != null && !newBill && !configurations)
        return MyAppConfiguration.billDetail(selectedBillId!);
      else if (selectedBillId == null && newBill && !configurations)
        return MyAppConfiguration.newBill();
      else if (selectedBillId == null && !newBill && configurations)
        return MyAppConfiguration.configurations();
      else
        return MyAppConfiguration.unknown();
    } else
      return MyAppConfiguration.unknown();
  }

  //set only the variable that is of interest to the path
  @override
  Future<void> setNewRoutePath(MyAppConfiguration configuration) async {
    if (configuration.isUnknown)
      show404 = true;
    else if (configuration.isLogin) {
      show404 = false;
      loggedIn = false;
    } else if (configuration.isSignUp) {
      show404 = false;
      loggedIn = false;
      signup = true;
    } else if (configuration.isBills) {
      show404 = false;
      selectedBillId = null;
      newBill = false;
    } else if (configuration.isBillDetail) {
      selectedBillId = configuration.billDetail;
      show404 = false;
      newBill = false;
    } else if (configuration.isNewBill) {
      selectedBillId = null;
      show404 = false;
      newBill = true;
    } else if (configuration.isConfigurations) {
      show404 = false;
      configurations = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Page> stack;
    if (show404)
      stack = [
        UnknownPage(backToHome: () {
          show404 = false;
        })
      ];
    else if (loggedIn == false && signup == false)
      stack = [
        LoginPage(onLogin: () {
          loggedIn = true;
        }, onSignUp: () {
          signup = true;
        })
      ];
    else if (signup == true && loggedIn == false)
      stack = [
        SignUpPage(onPop: () {
          signup = false;
        })
      ];
    else if (loggedIn) {
      if (!newBill && !configurations && selectedBillId == null)
        stack = [
          BillsListPage(onNewBill: () {
            newBill = true;
          }, onConfigurations: () {
            configurations = true;
          }, onSelect: (id) {
            selectedBillId = id;
          })
        ];
      else if (newBill && !configurations && selectedBillId == null)
        stack = [
          NewBillPage(onBack: () {
            newBill = false;
          })
        ];
      else if (!newBill && configurations && selectedBillId == null)
        stack = [/*ConfigurationsPage*/];
      else if (!newBill && !configurations && selectedBillId != null)
        stack = [
          BillDetailPage(
              billId: selectedBillId!,
              onBack: () {
                selectedBillId = null;
              })
        ];
      else
        stack = [
          UnknownPage(backToHome: () {
            show404 = false;
          })
        ];
    } else
      stack = [
        UnknownPage(backToHome: () {
          show404 = false;
        })
      ];
    return Navigator(
      key: navigatorKey,
      pages: stack,
      onPopPage: (route, result) {
        if (!route.didPop(result)) return false;
        if (_selectedBillId == null) selectedBillId = null;
        if (signup == true && loggedIn == false) signup = false;

        return true;
      },
    );
  }
}
