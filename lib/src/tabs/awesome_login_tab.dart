import 'package:awesome_login/src/widgets/apple_button.dart';
import 'package:awesome_login/src/widgets/google_button.dart';
import 'package:flutter/material.dart';
import '../awesome_login_config.dart';
import '../widgets/biometric_button.dart';

enum _Mode { login, register, recover }

typedef LoginCallback = Future<String?> Function(String email, String password);
typedef RegisterCallback = Future<String?> Function(
    String name, String email, String password);
typedef RecoverCallback = Future<String?> Function(String email);

class AwesomeLoginTab extends StatefulWidget {
  final AwesomeLoginConfig config;
  // ignore: library_private_types_in_public_api
  final _Mode mode;
  final LoginCallback? onLogin;
  final RegisterCallback? onRegister;
  final RecoverCallback? onRecover;

  const AwesomeLoginTab._({
    required this.config,
    required this.mode,
    this.onLogin,
    this.onRegister,
    this.onRecover,
  });

  factory AwesomeLoginTab.login({
    required AwesomeLoginConfig config,
    required Future<String?> Function(String, String) onSubmit,
  }) =>
      AwesomeLoginTab._(
          config: config, mode: _Mode.login, onLogin: onSubmit);

  factory AwesomeLoginTab.register({
    required AwesomeLoginConfig config,
    required Future<String?> Function(String, String, String)? onSubmit,
  }) =>
      AwesomeLoginTab._(
          config: config, mode: _Mode.register, onRegister: onSubmit);

  factory AwesomeLoginTab.recover({
    required AwesomeLoginConfig config,
    required Future<String?> Function(String)? onSubmit,
  }) =>
      AwesomeLoginTab._(
          config: config, mode: _Mode.recover, onRecover: onSubmit);

  @override
  State<AwesomeLoginTab> createState() => _AwesomeLoginTabState();
}

class _AwesomeLoginTabState extends State<AwesomeLoginTab> {
  final _formKey = GlobalKey<FormState>();

  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _nameCtrl = TextEditingController();

  bool _loading = false;
  String? _message;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _nameCtrl.dispose();
    super.dispose();
  }

  String? _validateEmail(String? v) {
    if (v == null || v.trim().isEmpty) return 'Campo requerido';
    final pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    final reg = RegExp(pattern);
    if (!reg.hasMatch(v.trim())) return 'Formato inválido';
    return null;
  }

  String? _validatePassword(String? v) {
    if (v == null || v.isEmpty) return 'Campo requerido';
    if (v.length < 6) return 'Mínimo 6 caracteres';
    return null;
  }

  String? _validateName(String? v) {
    if (v == null || v.trim().isEmpty) return 'Campo requerido';
    return null;
  }

  Future<void> _submit() async {
    setState(() {
      _message = null;
    });

    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);

    try {
      if (widget.mode == _Mode.login) {
        final cb = widget.onLogin;
        if (cb != null) {
          final res = await cb(_emailCtrl.text.trim(), _passwordCtrl.text);
          setState(() => _message = res);
        }
      } else if (widget.mode == _Mode.register) {
        final cb = widget.onRegister;
        if (cb != null) {
          final res = await cb(
              _nameCtrl.text.trim(), _emailCtrl.text.trim(), _passwordCtrl.text);
          setState(() => _message = res);
        }
      } else {
        final cb = widget.onRecover;
        if (cb != null) {
          final res = await cb(_emailCtrl.text.trim());
          setState(() => _message = res);
        }
      }
    } catch (e) {
      setState(() => _message = 'Error: $e');
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cfg = widget.config;

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.0),
        child: Column(
          children: [
            if (widget.mode == _Mode.register) ...[
              TextFormField(
                controller: _nameCtrl,
                decoration: InputDecoration(
                  labelText: cfg.nameLabel,
                  hintText: cfg.nameHint,
                ),
                validator: _validateName,
              ),
              const SizedBox(height: 12),
            ],

            TextFormField(
              controller: _emailCtrl,
              decoration: InputDecoration(
                labelText: cfg.emailLabel,
                hintText: cfg.emailHint,
              ),
              validator: _validateEmail,
              keyboardType: TextInputType.emailAddress,
            ),

            const SizedBox(height: 12),

            if (widget.mode != _Mode.recover) ...[
              TextFormField(
                controller: _passwordCtrl,
                decoration: InputDecoration(
                  labelText: cfg.passwordLabel,
                  hintText: cfg.passwordHint,
                ),
                validator: _validatePassword,
                obscureText: true,
              ),
              const SizedBox(height: 12),
            ],

            const SizedBox(height: 8),

            if (_message != null) ...[
              Text(
                _message!,
                style: TextStyle(
                    color: _message!.contains('error', 0) ||
                            _message!.toLowerCase().contains('error') ||
                            _message!.toLowerCase().contains('incorrect')
                        ? Colors.red
                        : Colors.green),
              ),
              const SizedBox(height: 8),
            ],

            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _loading ? null : _submit,
                child: _loading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(
                        widget.mode == _Mode.login
                            ? cfg.loginButtonText
                            : widget.mode == _Mode.register
                                ? cfg.registerButtonText
                                : cfg.recoverButtonText,
                      ),
              ),
            ),

            const SizedBox(height: 8),

            // Biometric (solo en login)
            if (widget.mode == _Mode.login)
              BiometricButton(
                text: cfg.biometricButtonText,
                onAuthenticated: () async {
                  // Convención: cuando se autentica con biometría,
                  // llamamos onLogin con dos valores especiales "biometric"
                  // El desarrollador decide cómo mapearlos en su backend.
                  if (widget.onLogin != null) {
                    setState(() => _loading = true);
                    final res = await widget.onLogin!("biometric", "biometric");
                    setState(() {
                      _loading = false;
                      _message = res;
                    });
                  }
                },
              ),
            if (widget.config.onGoogleSignIn != null) ...[
              GoogleButton(
                text: widget.config.googleButtonText,
                onPressed: () async {
                  setState(() => _loading = true);
                  final res = await widget.config.onGoogleSignIn!();
                  setState(() {
                    _loading = false;
                    _message = res;
                  });
                },
              ),
              const SizedBox(height: 8),
            ],

            if (widget.config.onAppleSignIn != null) ...[
              AppleButton(
                text: widget.config.appleButtonText,
                onPressed: () async {
                  setState(() => _loading = true);
                  final res = await widget.config.onAppleSignIn!();
                  setState(() {
                    _loading = false;
                    _message = res;
                  });
                },
              ),
              const SizedBox(height: 8),
            ],
          ],
        ),
      ),
    );
  }
}
