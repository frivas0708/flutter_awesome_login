import 'package:flutter/material.dart';

/// Configuration object to customize the package
class AwesomeLoginConfig {
  final Widget? logo;
  final Color backgroundColor;
  final Color primaryColor;
  final Color accentColor;
  final Color cardColor;
  final double cardElevation;
  final Color cardShadowColor;

  // Texts
  final String loginTitle;
  final String registerTitle;
  final String recoverTitle;

  // Placeholders / Labels
  final String emailLabel;
  final String emailHint;
  final String passwordLabel;
  final String passwordHint;
  final String nameLabel;
  final String nameHint;

  // Button texts
  final String loginButtonText;
  final String registerButtonText;
  final String recoverButtonText;
  final String biometricButtonText;

  final Future<String?> Function()? onGoogleSignIn;
  final Future<String?> Function()? onAppleSignIn;

  final String googleButtonText;
  final String appleButtonText;

  const AwesomeLoginConfig({
    this.logo,
    this.backgroundColor = const Color(0xFFF6F9FF),
    this.primaryColor = const Color(0xFF0D6EFD),
    this.accentColor = Colors.white,
    this.cardColor = Colors.white,
    this.cardElevation = 8.0,
    this.cardShadowColor = Colors.black26,
    this.loginTitle = 'Iniciar Sesión',
    this.registerTitle = 'Registro',
    this.recoverTitle = 'Recuperar Contraseña',
    this.emailLabel = 'Correo',
    this.emailHint = 'correo@ejemplo.com',
    this.passwordLabel = 'Contraseña',
    this.passwordHint = '********',
    this.nameLabel = 'Nombre',
    this.nameHint = 'Tu nombre completo',
    this.loginButtonText = 'Iniciar sesión',
    this.registerButtonText = 'Registrar',
    this.recoverButtonText = 'Enviar',
    this.biometricButtonText = 'Usar biometría',
    this.onGoogleSignIn,
    this.onAppleSignIn,
    this.googleButtonText = "Continuar con Google",
    this.appleButtonText = "Continuar con Apple",
  });
}
