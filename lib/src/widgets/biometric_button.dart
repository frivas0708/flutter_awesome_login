import 'package:flutter/material.dart';

class BiometricButton extends StatelessWidget {
  final String text;
  final Future<void> Function()? onPressed;

  const BiometricButton({
    super.key,
    required this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      icon: const Icon(Icons.fingerprint),
      label: Text(text),
      onPressed: onPressed,
    );
  }
}