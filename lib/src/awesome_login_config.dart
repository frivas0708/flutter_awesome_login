import 'package:flutter/material.dart';

/// Configuración pública para personalizar el paquete.
class AwesomeLoginConfig {
  final Widget? logo;
  final Color backgroundColor;
  final Color primaryColor;
  final Color accentColor;
  final Color cardColor;
  final double cardElevation;
  final Color cardShadowColor;

  // Textos
  final String loginTitle;
  final String registerTitle;
  final String recoverTitle;
  final String loginButtonText;
  final String registerButtonText;
  final String recoverButtonText;
  final String biometricButtonText;

  //URL API
  final String apiUrl;

  // Callbacks principales
  final Future<String?> Function(String email, String password)? onLogin;
  final Future<String?> Function(String name, String email, String password)? onRegister;
  final Future<String?> Function(String email)? onRecover;

  // Biometría
  final bool enableBiometrics;
  final Future<String?> Function()? onBiometricAuth;

  // Social
  final bool enableGoogle;
  final bool enableApple;
  final Future<String?> Function()? onGoogleSignIn;
  final Future<String?> Function()? onAppleSignIn;

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
    this.loginButtonText = 'Iniciar sesión',
    this.registerButtonText = 'Registrar',
    this.recoverButtonText = 'Enviar',
    this.biometricButtonText = 'Usar biometría',
    this.apiUrl = "Url not set",
    this.onLogin,
    this.onRegister,
    this.onRecover,
    this.enableBiometrics = false,
    this.onBiometricAuth,
    this.enableGoogle = false,
    this.enableApple = false,
    this.onGoogleSignIn,
    this.onAppleSignIn,
  });

  /// Convenience copyWith to tweak config in example/demo
  AwesomeLoginConfig copyWith({
    Widget? logo,
    Color? backgroundColor,
    Color? primaryColor,
    Color? accentColor,
    Color? cardColor,
    double? cardElevation,
    Color? cardShadowColor,
    bool? enableBiometrics,
    Future<String?> Function()? onBiometricAuth,
    bool? enableGoogle,
    bool? enableApple,
    Future<String?> Function()? onGoogleSignIn,
    Future<String?> Function()? onAppleSignIn,
  }) {
    return AwesomeLoginConfig(
      logo: logo ?? this.logo,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      primaryColor: primaryColor ?? this.primaryColor,
      accentColor: accentColor ?? this.accentColor,
      cardColor: cardColor ?? this.cardColor,
      cardElevation: cardElevation ?? this.cardElevation,
      cardShadowColor: cardShadowColor ?? this.cardShadowColor,
      loginTitle: loginTitle,
      registerTitle: registerTitle,
      recoverTitle: recoverTitle,
      loginButtonText: loginButtonText,
      registerButtonText: registerButtonText,
      recoverButtonText: recoverButtonText,
      biometricButtonText: biometricButtonText,
      apiUrl: apiUrl,
      onLogin: onLogin,
      onRegister: onRegister,
      onRecover: onRecover,
      enableBiometrics: enableBiometrics ?? this.enableBiometrics,
      onBiometricAuth: onBiometricAuth ?? this.onBiometricAuth,
      enableGoogle: enableGoogle ?? this.enableGoogle,
      enableApple: enableApple ?? this.enableApple,
      onGoogleSignIn: onGoogleSignIn ?? this.onGoogleSignIn,
      onAppleSignIn: onAppleSignIn ?? this.onAppleSignIn,
    );
  }
}
