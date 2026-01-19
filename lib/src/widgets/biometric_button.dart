import 'package:flutter/material.dart';
import '../services/biometric_service.dart';

class BiometricButton extends StatefulWidget {
  final String text;
  final VoidCallback? onSuccess;

  const BiometricButton({super.key, required this.text, this.onSuccess});

  @override
  State<BiometricButton> createState() => _BiometricButtonState();
}

class _BiometricButtonState extends State<BiometricButton> {
  final BiometricService _svc = BiometricService();

  Future<void> _doAuth() async {
    final ok = await _svc.authenticate();
    if (ok) widget.onSuccess?.call();
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      icon: const Icon(Icons.fingerprint),
      label: Text(widget.text),
      onPressed: _doAuth,
    );
  }
}
