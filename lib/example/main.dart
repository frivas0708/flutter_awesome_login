import 'package:flutter/material.dart';
import 'package:awesome_login/awesome_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Awesome Login Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: DemoPage(),
    );
  }
}

class DemoPage extends StatelessWidget {
  DemoPage({super.key});

  final googleSignIn = GoogleSignIn();
  final appleSignIn = null; // Implementar si se desea

  final cfg = AwesomeLoginConfig(
    logo: Image.asset('assets/logo.png'),
    primaryColor: Colors.teal,
    accentColor: Colors.white,
  );

  Future<String?> onLogin(String email, String pass) async {
    // Simula validación
    await Future.delayed(const Duration(seconds: 1));
    if (email == 'test' && pass == '123456') return null;
    if (email == 'biometric' && pass == 'biometric') return null;
    return 'Credenciales incorrectas';
  }

  Future<String?> onRegister(String name, String email, String pass) async {
    await Future.delayed(const Duration(seconds: 1));
    return 'Registrado: $name';
  }

  Future<String?> onRecover(String email) async {
    await Future.delayed(const Duration(seconds: 1));
    return 'Correo de recuperación enviado a $email';
  }

  Future<String?> googleLogin() async {
    try {
      final user = await googleSignIn.signIn();
      if (user == null) return "Cancelado";
      return null; // <-  éxito
    } catch (e) {
      return "Error Google: $e";
    }
  }

  Future<String?> appleLogin() async {
    try {
      await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      return null; // OK
    } catch (e) {
      return "Error Apple: $e";
    }
  }

  @override
  Widget build(BuildContext context) {
    return AwesomeLoginScreen(
      config: AwesomeLoginConfig(
        logo: Image.asset('assets/logo.png'),
        primaryColor: Colors.teal,
        accentColor: Colors.white,
        onGoogleSignIn: googleLogin,
        onAppleSignIn: appleLogin, // opcional
      ),
      onLogin: onLogin,
      onRegister: onRegister,
      onRecover: onRecover,
    );
  }
}
