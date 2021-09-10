import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterpoc/config/get_it_registrations.dart';
import 'package:flutterpoc/src/services/login_services_abstract.dart';
import 'package:flutterpoc/src/view/login.dart';
import 'package:mockito/mockito.dart';
import 'package:progress_state_button/progress_button.dart';

void main() {
  getIt.registerSingleton<ILoginServices>(MockLoginServices());
  testWidgets('Login Widget is built', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: Login(
        onLogin: () {},
        onSignUp: () {},
      ),
    ));

    // Verify that the widgets with these texts are on screen
    expect(find.text('BYE\nBILLS'), findsOneWidget);
    expect(find.widgetWithText(TextFormField, 'email'), findsOneWidget);
    expect(find.widgetWithText(TextFormField, 'password'), findsOneWidget);
    expect(find.widgetWithText(ProgressButton, 'login'), findsOneWidget);
    expect(find.widgetWithText(TextButton, 'sign up'), findsOneWidget);
    expect(find.widgetWithText(TextButton, 'forgot password'), findsOneWidget);
  });
}

class MockLoginServices extends Mock implements ILoginServices {}
