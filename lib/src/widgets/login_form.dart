import 'package:flutter/material.dart';
import 'social_buttons.dart';

class LoginForm extends StatefulWidget {
  final Future<String?> Function(String email, String password) onLogin;
  final VoidCallback onSwitchRegister;
  final VoidCallback onSwitchForgot;

  final bool enableBiometrics;
  final Future<String?> Function()? onBiometricAuth;

  final bool enableGoogle;
  final bool enableApple;
  final Future<String?> Function()? onGoogleSignIn;
  final Future<String?> Function()? onAppleSignIn;

  const LoginForm({
    super.key,
    required this.onLogin,
    required this.onSwitchRegister,
    required this.onSwitchForgot,
    this.enableBiometrics = false,
    this.onBiometricAuth,
    this.enableGoogle = false,
    this.enableApple = false,
    this.onGoogleSignIn,
    this.onAppleSignIn,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _pass = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _email.dispose();
    _pass.dispose();
    super.dispose();
  }

  Future<void> _submit(String email, String pass) async {
    setState(() => _loading = true);
    final res = await widget.onLogin(email, pass);
    setState(() => _loading = false);
    if (res != null) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(backgroundColor: Colors.red, content: Text(res)));
      }
    }
  }

  Future<void> _doBiometric() async {
    if (widget.onBiometricAuth == null) return;

    setState(() => _loading = true);

    final res = await widget.onBiometricAuth!();

    setState(() => _loading = false);

    if (res != null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(backgroundColor: Colors.red, content: Text(res)),
      );
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
                  decoration: const InputDecoration(
                    border: InputBorder.none,   // 🔥 QUITAR ESTILO MATERIAL
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
              const SizedBox(height: 14),
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
                      ? const CircularProgressIndicator()
                      : const Text('Ingresar'),
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
        if (widget.enableBiometrics && widget.onBiometricAuth != null) ...[
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: _doBiometric,
            icon: const Icon(Icons.fingerprint),
            label: const Text('Ingresar con biometría'),
          ),
        ],
        if (widget.enableGoogle || widget.enableApple) ...[
          const SizedBox(height: 8),
          SocialButtons(
            showGoogle: widget.enableGoogle,
            showApple: widget.enableApple,
            onGooglePress: widget.onGoogleSignIn,
            onApplePress: widget.onAppleSignIn,
            onSocialResult: (email, provider) async {
              // por convención llamamos onLogin con email + provider
              await _submit(email ?? provider, provider);
            },
          ),
        ],
      ],
    );
  }
}
