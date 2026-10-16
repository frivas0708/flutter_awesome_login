import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/login_result.dart';
import 'social_buttons.dart';

class LoginForm extends StatefulWidget {
  final Future<LoginResult> Function(String email, String password) onLogin;
  final VoidCallback onSwitchRegister;
  final VoidCallback onSwitchForgot;
  final VoidCallback onSwitchTwoFactor;
  final VoidCallback onSwitchChangePassword;

  final bool enableBiometrics;
  final Future<LoginResult> Function()? onBiometricAuth;

  final bool enableGoogle;
  final bool enableApple;
  final Future<LoginResult> Function()? onGoogleSignIn;
  final Future<LoginResult> Function()? onAppleSignIn;

  final bool enableRememberEmail;
  final String rememberEmailText;
  final String loginButtonText;
  final String biometricButtonText;

  const LoginForm({
    super.key,
    required this.onLogin,
    required this.onSwitchRegister,
    required this.onSwitchForgot,
    required this.onSwitchTwoFactor,
    required this.onSwitchChangePassword,
    this.enableBiometrics = false,
    this.onBiometricAuth,
    this.enableGoogle = false,
    this.enableApple = false,
    this.onGoogleSignIn,
    this.onAppleSignIn,
    this.enableRememberEmail = true,
    this.rememberEmailText = 'Recordar correo',
    this.loginButtonText = 'Iniciar sesión',
    this.biometricButtonText = 'Ingresar con biometría',
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _pass = TextEditingController();
  bool _loading = false;
  bool _rememberEmail = false;

  static const _storage = FlutterSecureStorage();
  static const _savedEmailKey = 'awesome_login_saved_email';
  static const _rememberEmailKey = 'awesome_login_remember_email';

  @override
  void initState() {
    super.initState();
    _loadSavedEmail();
  }

  Future<void> _loadSavedEmail() async {
    if (!widget.enableRememberEmail) return;
    try {
      final savedEmail = await _storage.read(key: _savedEmailKey);
      final shouldRemember = await _storage.read(key: _rememberEmailKey);
      if (mounted && savedEmail != null && savedEmail.isNotEmpty) {
        setState(() {
          _email.text = savedEmail;
          _rememberEmail = shouldRemember != 'false';
        });
      }
    } catch (_) {}
  }

  @override
  void dispose() {
    _email.dispose();
    _pass.dispose();
    super.dispose();
  }

  void _handleResult(LoginResult res) {
    if (res.requires2FA) {
      widget.onSwitchTwoFactor();
    } else if (res.requiresPasswordChange) {
      widget.onSwitchChangePassword();
    } else if (!res.success && res.errorMessage != null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(backgroundColor: Colors.red, content: Text(res.errorMessage!)),
        );
      }
    }
  }

  Future<void> _submit(String email, String pass) async {
    setState(() => _loading = true);

    if (widget.enableRememberEmail) {
      try {
        if (_rememberEmail) {
          await _storage.write(key: _savedEmailKey, value: email);
          await _storage.write(key: _rememberEmailKey, value: 'true');
        } else {
          await _storage.delete(key: _savedEmailKey);
          await _storage.write(key: _rememberEmailKey, value: 'false');
        }
      } catch (_) {}
    }

    final res = await widget.onLogin(email, pass);
    if (mounted) {
      setState(() => _loading = false);
      _handleResult(res);
    }
  }

  Future<void> _doBiometric() async {
    if (widget.onBiometricAuth == null) return;

    setState(() => _loading = true);
    final res = await widget.onBiometricAuth!();
    if (mounted) {
      setState(() => _loading = false);
      _handleResult(res);
    }
  }

  bool get enableBiometrics {
    return widget.enableBiometrics && widget.onBiometricAuth != null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Iniciar Sesión', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 16),
        Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300, width: 1),
                ),
                child: TextFormField(
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Email',
                  ),
                  validator: (v) => (v == null || !v.contains('@')) ? 'Email inválido' : null,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300, width: 1),
                ),
                child: TextFormField(
                  controller: _pass,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Contraseña',
                  ),
                  validator: (v) => (v == null || v.length < 6) ? 'Mínimo 6 caracteres' : null,
                ),
              ),
              if (widget.enableRememberEmail) ...[
                const SizedBox(height: 6),
                Row(
                  children: [
                    SizedBox(
                      height: 24,
                      width: 24,
                      child: Checkbox(
                        value: _rememberEmail,
                        activeColor: Theme.of(context).primaryColor,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        onChanged: (val) {
                          setState(() => _rememberEmail = val ?? false);
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        setState(() => _rememberEmail = !_rememberEmail);
                      },
                      child: Text(
                        widget.rememberEmailText,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ] else ...[
                const SizedBox(height: 14),
              ],
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _loading
                      ? null
                      : () {
                          if (!_formKey.currentState!.validate()) return;
                          _submit(_email.text.trim(), _pass.text);
                        },
                  child: _loading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                        )
                      : Text(widget.loginButtonText),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        TextButton(
          onPressed: widget.onSwitchForgot,
          child: const Text('¿Olvidaste tu contraseña?'),
        ),
        TextButton(
          onPressed: widget.onSwitchRegister,
          child: const Text('Crear cuenta'),
        ),
        if (enableBiometrics) ...[
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: _doBiometric,
            icon: const Icon(Icons.fingerprint),
            label: Text(widget.biometricButtonText),
          ),
        ],
        if (widget.enableGoogle || widget.enableApple) ...[
          const SizedBox(height: 8),
          SocialButtons(
            showGoogle: widget.enableGoogle,
            showApple: widget.enableApple,
            onGooglePress: widget.onGoogleSignIn,
            onApplePress: widget.onAppleSignIn,
            onSocialResult: (res, provider) {
              _handleResult(res);
            },
          ),
        ],
      ],
    );
  }
}
