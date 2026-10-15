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
      home: const DemoPage(),
    );
  }
}

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  Future<LoginResult> onLogin(String email, String pass) async {
    await Future.delayed(const Duration(seconds: 1));
    if (email == '2fa') {
      return const LoginResult(requires2FA: true);
    }
    if (email == 'temp') {
      return const LoginResult(requiresPasswordChange: true);
    }
    if ((email == 'test@test.com' && pass == '123456') || email == 'biometric' || email == 'google' || email == 'apple') {
      return const LoginResult(success: true);
    }
    return const LoginResult(success: false, errorMessage: 'Credenciales incorrectas');
  }

  Future<String?> onRegister(String name, String email, String pass) async {
    await Future.delayed(const Duration(seconds: 1));
    return 'Registrado $name';
  }

  Future<String?> onRecover(String email) async {
    await Future.delayed(const Duration(seconds: 1));
    return 'Email enviado a $email';
  }

  Future<String?> onVerify2FA(String code) async {
    await Future.delayed(const Duration(seconds: 1));
    if (code == '1234') return null; // success
    return 'Código inválido';
  }

  Future<String?> onChangePassword(String newPassword) async {
    await Future.delayed(const Duration(seconds: 1));
    if (newPassword.length >= 6) return null; // success
    return 'Contraseña muy corta';
  }

  Future<LoginResult> googleSignIn() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return const LoginResult(success: true);
  }

  Future<LoginResult> appleSignIn() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return const LoginResult(success: true);
  }

  Future<LoginResult> biometricHandler() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return const LoginResult(success: true);
  }

  @override
  Widget build(BuildContext context) {
    final cfg = AwesomeLoginConfig(
      logo: Image.network('https://raw.githubusercontent.com/flutter/assets-for-api-docs/master/assets/widgets/owl-2.jpg'),
      primaryColor: Colors.teal,
      enableBiometrics: true,
      onBiometricAuth: biometricHandler,
      enableGoogle: true,
      onGoogleSignIn: googleSignIn,
      enableApple: true,
      onAppleSignIn: appleSignIn,
      onLogin: onLogin,
      onRegister: onRegister,
      onRecover: onRecover,
      onVerify2FA: onVerify2FA,
      onChangePassword: onChangePassword,
    );

    return AwesomeLoginScreen(
      config: cfg,
    );
  }
}

