import 'package:flutter/material.dart';
import 'models/login_result.dart';

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
  final String twoFactorTitle;
  final String changePasswordTitle;
  
  final String loginButtonText;
  final String registerButtonText;
  final String recoverButtonText;
  final String verifyButtonText;
  final String changePasswordButtonText;
  final String biometricButtonText;

  //URL API
  final String apiUrl;

  // Callbacks principales
  final Future<LoginResult> Function(String email, String password)? onLogin;
  final Future<String?> Function(String name, String email, String password)? onRegister;
  final VoidCallback? onCustomRegister;
  final Future<String?> Function(String email)? onRecover;
  final Future<String?> Function(String code)? onVerify2FA;
  final Future<String?> Function(String newPassword)? onChangePassword;

  // Biometría
  final bool enableBiometrics;
  final Future<LoginResult> Function()? onBiometricAuth;

  // Social
  final bool enableGoogle;
  final bool enableApple;

  // Recordar email
  final bool enableRememberEmail;
  final String rememberEmailText;
  final Future<LoginResult> Function()? onGoogleSignIn;
  final Future<LoginResult> Function()? onAppleSignIn;

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
    this.twoFactorTitle = 'Verificación de 2 Pasos',
    this.changePasswordTitle = 'Cambiar Contraseña',
    this.loginButtonText = 'Iniciar sesión',
    this.registerButtonText = 'Registrar',
    this.recoverButtonText = 'Enviar',
    this.verifyButtonText = 'Verificar',
    this.changePasswordButtonText = 'Cambiar',
    this.biometricButtonText = 'Usar biometría',
    this.apiUrl = "Url not set",
    this.onLogin,
    this.onRegister,
    this.onCustomRegister,
    this.onRecover,
    this.onVerify2FA,
    this.onChangePassword,
    this.enableBiometrics = false,
    this.onBiometricAuth,
    this.enableGoogle = false,
    this.enableApple = false,
    this.onGoogleSignIn,
    this.onAppleSignIn,
    this.enableRememberEmail = true,
    this.rememberEmailText = 'Recordar correo',
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
    Future<LoginResult> Function()? onBiometricAuth,
    VoidCallback? onCustomRegister,
    bool? enableGoogle,
    bool? enableApple,
    Future<LoginResult> Function()? onGoogleSignIn,
    Future<LoginResult> Function()? onAppleSignIn,
    bool? enableRememberEmail,
    String? rememberEmailText,
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
      twoFactorTitle: twoFactorTitle,
      changePasswordTitle: changePasswordTitle,
      loginButtonText: loginButtonText,
      registerButtonText: registerButtonText,
      recoverButtonText: recoverButtonText,
      verifyButtonText: verifyButtonText,
      changePasswordButtonText: changePasswordButtonText,
      biometricButtonText: biometricButtonText,
      apiUrl: apiUrl,
      onLogin: onLogin,
      onRegister: onRegister,
      onCustomRegister: onCustomRegister ?? this.onCustomRegister,
      onRecover: onRecover,
      onVerify2FA: onVerify2FA,
      onChangePassword: onChangePassword,
      enableBiometrics: enableBiometrics ?? this.enableBiometrics,
      onBiometricAuth: onBiometricAuth ?? this.onBiometricAuth,
      enableGoogle: enableGoogle ?? this.enableGoogle,
      enableApple: enableApple ?? this.enableApple,
      onGoogleSignIn: onGoogleSignIn ?? this.onGoogleSignIn,
      onAppleSignIn: onAppleSignIn ?? this.onAppleSignIn,
      enableRememberEmail: enableRememberEmail ?? this.enableRememberEmail,
      rememberEmailText: rememberEmailText ?? this.rememberEmailText,
    );
  }
}
