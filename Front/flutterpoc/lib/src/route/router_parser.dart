import 'package:flutter/material.dart';
import 'package:flutterpoc/src/route/app_configuration.dart';

class BillRouteParser extends RouteInformationParser<MyAppConfiguration> {
  @override
  Future<MyAppConfiguration> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location!);

    //if there is nothing in the location, we should go to home page
    if (uri.pathSegments.length == 0)
      return MyAppConfiguration.bills();

    //if there is one segment in the location, there must be login, home, configuration or signup page
    else if (uri.pathSegments.length == 1) {
      final first = uri.pathSegments[0].toLowerCase();
      if (first == 'bills')
        return MyAppConfiguration.bills();
      else if (first == 'login')
        return MyAppConfiguration.login();
      else if (first == 'signup')
        return MyAppConfiguration.signup();
      else if (first == 'configuration')
        return MyAppConfiguration.configurations();
      else
        MyAppConfiguration.unknown();
    }

    //if there is two segments, there must be bill detail or new bill
    else if (uri.pathSegments.length == 2) {
      final first = uri.pathSegments[0].toLowerCase();
      final second = uri.pathSegments[1].toLowerCase();

      if (first == 'bills') {
        int? id = int.tryParse(second);
        if (second == 'new')
          return MyAppConfiguration.newBill();
        else if (id != null)
          return MyAppConfiguration.billDetail(id);
        else
          return MyAppConfiguration.unknown();
      } else
        return MyAppConfiguration.unknown();
    }

    return MyAppConfiguration.unknown();
  }

  @override
  RouteInformation restoreRouteInformation(MyAppConfiguration configuration) {
    if (configuration.isUnknown)
      return RouteInformation(location: '/unknown');
    else if (configuration.isLogin)
      return RouteInformation(location: '/login');
    else if (configuration.isSignUp)
      return RouteInformation(location: '/signup');
    else if (configuration.isBills)
      return RouteInformation(location: '/bills');
    else if (configuration.isNewBill)
      return RouteInformation(location: '/bills/new');
    else if (configuration.isBillDetail)
      return RouteInformation(location: '/bills/${configuration.billDetail}');
    else if (configuration.isConfigurations)
      return RouteInformation(location: '/configurations');
    return RouteInformation(location: '/');
  }
}
