import 'package:flutter/material.dart';

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
    final platform = Theme.of(context).platform;
    if (platform != TargetPlatform.iOS && platform != TargetPlatform.macOS) {
      return const SizedBox.shrink();
    }

    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.apple, size: 22),
      label: Text(text),
    );
  }
}
