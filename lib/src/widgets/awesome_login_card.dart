import 'dart:math';
import 'package:flutter/material.dart';

import '../awesome_login_config.dart';
import 'login_form.dart';
import 'register_form.dart';
import 'forgot_password_form.dart';

enum _Mode { login, register, recover }

class AwesomeLoginCard extends StatefulWidget {
  final AwesomeLoginConfig config;

  const AwesomeLoginCard({super.key, required this.config});

  @override
  State<AwesomeLoginCard> createState() => _AwesomeLoginCardState();
}

class _AwesomeLoginCardState extends State<AwesomeLoginCard>
    with SingleTickerProviderStateMixin {
  _Mode _mode = _Mode.login;
  _Mode? _targetMode;

  late AnimationController _controller;
  late Animation<double> _anim;

  // Nueva variable para saber si el flip debe ir al revés
  bool _reverseFlip = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _anim = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  /// Decide si el flip debe ser normal o inverso
  void _flipTo(_Mode m) {
    if (_mode == m) return;

    _targetMode = m;

    // Reglas para flip inverso:
    // - Si volvemos al login desde register o recover → flip hacia la derecha (inverso)
    if ((_mode == _Mode.register || _mode == _Mode.recover) && m == _Mode.login) {
      _reverseFlip = true;
    } else {
      _reverseFlip = false;
    }

    _controller.forward(from: 0).then((_) {
      setState(() {
        _mode = m;
        _targetMode = null;
      });
    });
  }

  Widget _buildSide(_Mode mode) {
    final cfg = widget.config;

    switch (mode) {
      case _Mode.login:
        return LoginForm(
          key: const ValueKey('login'),
          onLogin: cfg.onLogin!,
          onSwitchRegister: () => _flipTo(_Mode.register),
          onSwitchForgot: () => _flipTo(_Mode.recover),
          enableBiometrics: cfg.enableBiometrics,
          onBiometricAuth: cfg.onBiometricAuth,
          enableGoogle: cfg.enableGoogle,
          enableApple: cfg.enableApple,
          onGoogleSignIn: cfg.onGoogleSignIn,
          onAppleSignIn: cfg.onAppleSignIn,
        );
      case _Mode.register:
        return RegisterForm(
          key: const ValueKey('register'),
          onRegister: cfg.onRegister!,
          onSwitchLogin: () => _flipTo(_Mode.login),
        );
      case _Mode.recover:
        return ForgotPasswordForm(
          key: const ValueKey('recover'),
          onRecover: cfg.onRecover!,
          onSwitchLogin: () => _flipTo(_Mode.login),
        );
    }
  }

  Widget _buildAnimatedCard(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (context, child) {
        final progress = _anim.value;

        final angle = (_reverseFlip ? -1 : 1) * progress * pi;

        final bool isFront = progress < 0.5;

        final Matrix4 transform = Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateY(angle);

        final Widget visibleChild =
            isFront ? _buildSide(_mode) : _buildSide(_targetMode ?? _mode);

        return Transform(
          transform: transform,
          alignment: Alignment.center,
          child: Transform(
            alignment: Alignment.center,
            transform: isFront
                ? Matrix4.identity()
                : (Matrix4.identity()..rotateY(pi)),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              child: Card(
                elevation: widget.config.cardElevation,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: constraints.minHeight,
                          ),
                          child: IntrinsicHeight(
                            child: visibleChild,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildAnimatedCard(context);
  }
}
