import 'package:awesome_login/awesome_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _buildLogin({
  bool showRegisterButton = true,
  bool hasRegistrationHandler = false,
  bool hasCustomRegistrationHandler = false,
}) {
  return MaterialApp(
    home: AwesomeLoginScreen(
      config: AwesomeLoginConfig(
        onLogin: (email, password) async => const LoginResult(success: true),
        onRegister: hasRegistrationHandler
            ? (name, email, password) async => null
            : null,
        onCustomRegister: hasCustomRegistrationHandler ? () {} : null,
        showRegisterButton: showRegisterButton,
      ),
    ),
  );
}

void main() {
  testWidgets('hides registration link when no handler is configured',
      (tester) async {
    await tester.pumpWidget(_buildLogin());

    expect(find.text('Crear cuenta'), findsNothing);
  });

  testWidgets('shows registration link when a handler is configured',
      (tester) async {
    await tester.pumpWidget(_buildLogin(hasRegistrationHandler: true));

    expect(find.text('Crear cuenta'), findsOneWidget);
  });

  testWidgets('shows registration link when a custom handler is configured',
      (tester) async {
    await tester.pumpWidget(_buildLogin(hasCustomRegistrationHandler: true));

    expect(find.text('Crear cuenta'), findsOneWidget);
  });

  testWidgets('can hide registration link when a handler is configured',
      (tester) async {
    await tester.pumpWidget(
      _buildLogin(
        hasRegistrationHandler: true,
        showRegisterButton: false,
      ),
    );

    expect(find.text('Crear cuenta'), findsNothing);
  });
}
