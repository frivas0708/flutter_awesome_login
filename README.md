# Awesome Login

[![pub package](https://img.shields.io/pub/v/awesome_login.svg)](https://pub.dev/packages/awesome_login)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

A modern, responsive, and animated authentication card for Flutter applications. It seamlessly integrates **Login**, **Registration**, **Password Recovery**, **2FA Verification**, and **Biometric Authentication** in a sleek, customizable card with smooth flip animations.

---

## ✨ Features

- 🔄 **Smooth Flip Card Animations**: Seamlessly transitions between Login, Registration, and Forgot Password views.
- 📱 **Responsive Design**: Looks stunning on Mobile (iOS & Android), Tablet, Desktop, and Web.
- 👆 **Biometric Authentication**: One-tap fingerprint / Face ID login integration via `local_auth`.
- 🔐 **Two-Factor Authentication (2FA)**: Built-in verification screen for 6-digit OTP codes.
- 🔑 **Force Password Change Support**: Built-in dialog for temporary password expirations.
- 🌐 **Social Sign-In Buttons**: Optional Google & Apple sign-in hooks.
- 🎯 **Decoupled Architecture (`onCustomRegister`)**: Easily plug in your own custom multi-step registration or SaaS onboarding wizard.
- 🎨 **Highly Customizable**: Custom logos, background colors, card colors, button text, and titles.

---

## 🚀 Getting Started

Add `awesome_login` to your `pubspec.yaml`:

```yaml
dependencies:
  awesome_login: ^1.0.3
```

Or run:

```bash
flutter pub add awesome_login
```

---

## 💡 Quick Start

```dart
import 'package:flutter/material.dart';
import 'package:awesome_login/awesome_login.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  Future<LoginResult> _handleLogin(String email, String password) async {
    // Your authentication logic here
    if (email == 'user@example.com' && password == 'secret') {
      return const LoginResult(success: true);
    }
    return const LoginResult(
      success: false, 
      errorMessage: 'Invalid credentials',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AwesomeLoginScreen(
        config: AwesomeLoginConfig(
          logo: Image.asset('assets/logo.png'),
          backgroundColor: const Color(0xFF1E3A8A),
          cardColor: Colors.white,
          enableBiometrics: true,
          enableRememberEmail: true,
          onLogin: _handleLogin,
          onRegister: (name, email, pass) async {
            // Handle standard registration
            return null; // return error message or null on success
          },
          onRecover: (email) async {
            // Handle forgot password
            return 'Instructions sent to your email';
          },
        ),
      ),
    );
  }
}
```

---

## 🛠️ Custom Registration Wizard (`onCustomRegister`)

If your app requires a custom registration flow (e.g., choosing a church plan, multi-step onboarding, or business registration), simply supply `onCustomRegister`:

```dart
AwesomeLoginConfig(
  onLogin: _handleLogin,
  onCustomRegister: () {
    // Redirects to your custom onboarding screen instead of internal registration
    Navigator.pushNamed(context, '/register-church');
  },
)
```

When `onCustomRegister` is `null`, the widget flips to its built-in name/email/password registration card.

---

## ⚙️ Configuration Options (`AwesomeLoginConfig`)

| Parameter | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `logo` | `Widget?` | `null` | Top floating logo widget |
| `backgroundColor` | `Color` | `Color(0xFF0F172A)` | Background color of the screen |
| `cardColor` | `Color` | `Colors.white` | Color of the flip card |
| `enableBiometrics` | `bool` | `false` | Shows biometric login button |
| `enableGoogle` | `bool` | `false` | Shows Google sign-in button |
| `enableApple` | `bool` | `false` | Shows Apple sign-in button |
| `enableRememberEmail` | `bool` | `true` | Enables "Remember email" checkbox |
| `twoFactorTitle` | `String` | `'Verificación 2FA'` | Title for 2FA screen |
| `changePasswordTitle` | `String` | `'Cambiar Contraseña'`| Title for force password change |
| `recoverTitle` | `String` | `'Recuperar Contraseña'`| Title for forgot password |
| `onLogin` | `Future<LoginResult> Function(String, String)` | **Required** | Triggered on login submit |
| `onRegister` | `Future<String?> Function(String, String, String)?` | `null` | Built-in registration handler |
| `onCustomRegister` | `VoidCallback?` | `null` | Custom registration callback |
| `onRecover` | `Future<String?> Function(String)?` | `null` | Forgot password handler |
| `onVerify2FA` | `Future<LoginResult> Function(String)?` | `null` | 2FA OTP code verification handler |

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
