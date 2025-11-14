import 'package:flutter/material.dart';

class GoogleButton extends StatelessWidget {
  final String text;
  final Future<void> Function() onPressed;

  const GoogleButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Colors.black12),
      ),
      onPressed: onPressed,
      icon: Image.network(
        "https://img.icons8.com/color/48/google-logo.png",
        width: 20,
        height: 20,
      ),
      label: Text(text),
    );
  }
}
