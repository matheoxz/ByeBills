class MyAppConfiguration {
  final bool? loggedIn;
  final bool? newBill;
  final bool? newAccount;
  final bool? error;
  final bool? unknown;
  final bool? configurations;
  final int? billDetail;

  MyAppConfiguration.login()
      : loggedIn = false,
        newBill = false,
        newAccount = false,
        unknown = false,
        error = false,
        configurations = null,
        billDetail = null;

  MyAppConfiguration.signup()
      : loggedIn = false,
        newBill = false,
        newAccount = true,
        unknown = false,
        error = false,
        configurations = null,
        billDetail = null;

  MyAppConfiguration.bills()
      : loggedIn = true,
        newBill = false,
        newAccount = false,
        unknown = false,
        error = false,
        configurations = null,
        billDetail = null;

  MyAppConfiguration.newBill()
      : loggedIn = true,
        newBill = true,
        newAccount = false,
        unknown = false,
        error = false,
        configurations = null,
        billDetail = null;

  MyAppConfiguration.billDetail(int billId)
      : loggedIn = true,
        newBill = false,
        newAccount = false,
        unknown = false,
        error = false,
        configurations = null,
        billDetail = billId;

  MyAppConfiguration.configurations()
      : loggedIn = true,
        newBill = false,
        newAccount = false,
        unknown = false,
        error = false,
        configurations = true,
        billDetail = null;

  MyAppConfiguration.unknown()
      : loggedIn = null,
        newBill = null,
        newAccount = null,
        unknown = true,
        error = null,
        configurations = null,
        billDetail = null;

  MyAppConfiguration.error()
      : loggedIn = null,
        newBill = null,
        newAccount = null,
        unknown = null,
        error = true,
        configurations = null,
        billDetail = null;

  bool get isUnknown => unknown == true;
  bool get isError => error == true;
  bool get isLogin => loggedIn == false && newAccount == false;
  bool get isSignUp => loggedIn == false && newAccount == true;
  bool get isBills => loggedIn == true && newBill == false;
  bool get isNewBill => loggedIn == true && newBill == true;
  bool get isBillDetail =>
      loggedIn == true && newBill == false && billDetail != null;
  bool get isConfigurations =>
      loggedIn == true && newBill == false && configurations == true;
}
