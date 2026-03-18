import 'package:flutter/material.dart';
import 'package:awesome_login/awesome_login.dart';

// Example only: example/pubspec.yaml must include google_sign_in & sign_in_with_apple if used.

void main() {
  runApp(const DemoApp());
}

class DemoApp extends StatelessWidget {
  const DemoApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Awesome Login Demo',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: DemoPage(),
    );
  }
}

class DemoPage extends StatelessWidget {
  DemoPage({super.key});

  final cfg = AwesomeLoginConfig(
    logo: Image.network('https://raw.githubusercontent.com/flutter/assets-for-api-docs/master/assets/widgets/owl-2.jpg'),
    primaryColor: Colors.teal,
    enableBiometrics: true,
    enableGoogle: true,
    enableApple: true,
  );

  Future<String?> onLogin(String email, String pass) async {
    await Future.delayed(const Duration(seconds: 1));
    if ((email == 'test@test.com' && pass == '123456') || email == 'biometric' || email == 'google' || email == 'apple') return null;
    return 'Credenciales incorrectas';
  }

  Future<String?> onRegister(String name, String email, String pass) async {
    await Future.delayed(const Duration(seconds: 1));
    return 'Registrado $name';
  }

  Future<String?> onRecover(String email) async {
    await Future.delayed(const Duration(seconds: 1));
    return 'Email enviado a $email';
  }

  Future<String?> googleSignIn() async {
    // Si quieres usar google_sign_in, agrega en example/pubspec.yaml y usa GoogleService directamente.
    // Aquí devolvemos 'google' para demo.
    await Future.delayed(const Duration(milliseconds: 500));
    return 'google'; // email placeholder
  }

  Future<String?> appleSignIn() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return 'apple';
  }

  Future<String?> biometricHandler() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final finalCfg = cfg.copyWith(
      enableBiometrics: true,
      onBiometricAuth: biometricHandler,
      enableGoogle: true,
      onGoogleSignIn: googleSignIn,
      enableApple: true,
      onAppleSignIn: appleSignIn,
    );

    return AwesomeLoginScreen(
      config: finalCfg.copyWith(),
      // Note: config contains social / biometric callbacks,
      // but we still pass main callbacks here to handle email/password flows:
    );
  }
}
