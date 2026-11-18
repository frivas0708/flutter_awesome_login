import 'package:awesome_login/awesome_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _buildLogin({
  bool showRegisterButton = true,
  bool hasRegistrationHandler = false,
  bool hasCustomRegistrationHandler = false,
  AwesomeLoginConfig? config,
}) {
  return MaterialApp(
    home: AwesomeLoginScreen(
      config: config ??
          AwesomeLoginConfig(
            onLogin: (email, password) async =>
                const LoginResult(success: true),
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

  testWidgets('uses configured login hints and can toggle password visibility',
      (tester) async {
    await tester.pumpWidget(
      _buildLogin(
        config: AwesomeLoginConfig(
          enableRememberEmail: false,
          loginEmailHintText: 'Correo de acceso',
          loginPasswordHintText: 'Clave de acceso',
          onLogin: (email, password) async => const LoginResult(success: true),
        ),
      ),
    );

    expect(find.text('Correo de acceso'), findsOneWidget);
    expect(find.text('Clave de acceso'), findsOneWidget);
    expect(
      tester.widget<EditableText>(find.byType(EditableText).last).obscureText,
      isTrue,
    );

    await tester.tap(find.byTooltip('Mostrar contraseña'));
    await tester.pump();

    expect(
      tester.widget<EditableText>(find.byType(EditableText).last).obscureText,
      isFalse,
    );
    expect(find.byTooltip('Ocultar contraseña'), findsOneWidget);
  });

  testWidgets('uses configured hints in registration and recovery forms',
      (tester) async {
    await tester.pumpWidget(
      _buildLogin(
        config: AwesomeLoginConfig(
          enableRememberEmail: false,
          loginEmailHintText: 'Correo de acceso',
          registerNameHintText: 'Nombre completo',
          registerEmailHintText: 'Correo de registro',
          registerPasswordHintText: 'Clave nueva',
          recoverEmailHintText: 'Correo de recuperación',
          onLogin: (email, password) async => const LoginResult(success: true),
          onRegister: (name, email, password) async => null,
          onRecover: (email) async => null,
        ),
      ),
    );

    await tester.tap(find.text('Crear cuenta'));
    await tester.pumpAndSettle();

    expect(find.text('Nombre completo'), findsOneWidget);
    expect(find.text('Correo de registro'), findsOneWidget);
    expect(find.text('Clave nueva'), findsOneWidget);

    await tester.tap(find.text('Ya tengo cuenta'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('¿Olvidaste tu contraseña?'));
    await tester.pumpAndSettle();

    expect(find.text('Correo de recuperación'), findsOneWidget);
  });

  testWidgets('uses configured hints in the 2FA form', (tester) async {
    await tester.pumpWidget(
      _buildLogin(
        config: AwesomeLoginConfig(
          enableRememberEmail: false,
          twoFactorCodeHintText: 'Código de seguridad',
          onLogin: (email, password) async =>
              const LoginResult(requires2FA: true),
        ),
      ),
    );

    await tester.enterText(
      find.byType(TextFormField).at(0),
      'user@example.com',
    );
    await tester.enterText(find.byType(TextFormField).at(1), 'password');
    await tester.tap(find.text('Iniciar sesión'));
    await tester.pumpAndSettle();

    expect(find.text('Código de seguridad'), findsOneWidget);
  });

  testWidgets('uses configured hints in the password-change form',
      (tester) async {
    await tester.pumpWidget(
      _buildLogin(
        config: AwesomeLoginConfig(
          enableRememberEmail: false,
          changePasswordNewPasswordHintText: 'Nueva clave',
          changePasswordConfirmPasswordHintText: 'Repite la clave',
          onLogin: (email, password) async =>
              const LoginResult(requiresPasswordChange: true),
        ),
      ),
    );

    await tester.enterText(
      find.byType(TextFormField).at(0),
      'user@example.com',
    );
    await tester.enterText(find.byType(TextFormField).at(1), 'password');
    await tester.tap(find.text('Iniciar sesión'));
    await tester.pumpAndSettle();

    expect(find.text('Nueva clave'), findsOneWidget);
    expect(find.text('Repite la clave'), findsOneWidget);
    expect(find.byTooltip('Mostrar contraseña'), findsNWidgets(2));
  });
}
