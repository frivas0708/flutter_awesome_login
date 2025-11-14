import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class AppleButton extends StatelessWidget {
  final String text;
  final Future<void> Function() onPressed;

  const AppleButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    if (!Platform.isIOS && !Platform.isMacOS) {
      return const SizedBox.shrink();
    }

    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.apple, size: 22),
      label: Text(text),
    );
  }
}
