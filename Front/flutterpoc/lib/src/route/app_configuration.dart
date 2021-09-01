import 'package:flutterpoc/src/models/bill.dart';
import 'package:flutterpoc/src/models/user.dart';

class MyAppConfiguration {
  final bool loggedIn;
  final bool newBill;
  final bool newAccount;
  final bool error;
  final bool unknown;
  final UserModel? loggedUser;
  final BillModel? billDetail;

  MyAppConfiguration.login()
      : loggedIn = false,
        newBill = false,
        newAccount = false,
        unknown = false,
        error = false,
        loggedUser = null,
        billDetail = null;

  MyAppConfiguration.newAccount()
      : loggedIn = false,
        newBill = false,
        newAccount = true,
        unknown = false,
        error = false,
        loggedUser = null,
        billDetail = null;

  MyAppConfiguration.billsList()
      : loggedIn = true,
        newBill = false,
        newAccount = false,
        unknown = false,
        error = false,
        loggedUser = null,
        billDetail = null;

  MyAppConfiguration.newBill()
      : loggedIn = true,
        newBill = true,
        newAccount = false,
        unknown = false,
        error = false,
        loggedUser = null,
        billDetail = null;

  MyAppConfiguration.billDetail(BillModel bill)
      : loggedIn = true,
        newBill = false,
        newAccount = false,
        unknown = false,
        error = false,
        loggedUser = null,
        billDetail = bill;

  MyAppConfiguration.configurations(UserModel user)
      : loggedIn = true,
        newBill = false,
        newAccount = false,
        unknown = false,
        error = false,
        loggedUser = user,
        billDetail = null;

  MyAppConfiguration.unknown()
      : loggedIn = false,
        newBill = false,
        newAccount = false,
        unknown = true,
        error = false,
        loggedUser = null,
        billDetail = null;

  MyAppConfiguration.error()
      : loggedIn = false,
        newBill = false,
        newAccount = false,
        unknown = false,
        error = true,
        loggedUser = null,
        billDetail = null;
}
