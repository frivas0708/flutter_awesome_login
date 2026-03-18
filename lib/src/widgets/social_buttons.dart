import 'package:flutter/material.dart';

typedef SocialResult = void Function(String? email, String provider);

class SocialButtons extends StatelessWidget {
  final bool showGoogle;
  final bool showApple;

  final Future<String?> Function()? onGooglePress;
  final Future<String?> Function()? onApplePress;

  final SocialResult? onSocialResult;

  const SocialButtons({
    super.key,
    this.showGoogle = true,
    this.showApple = true,
    this.onGooglePress,
    this.onApplePress,
    this.onSocialResult,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (showGoogle)
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              icon: Image.network(
                'https://img.icons8.com/color/48/google-logo.png',
                width: 20,
                height: 20,
              ),
              label: const Text('Ingresar con Google'),
              onPressed: () async {
                if (onGooglePress == null) return;

                final email = await onGooglePress!();
                onSocialResult?.call(email, 'google');
              },
            ),
          ),

        if (showApple) const SizedBox(height: 8),

        if (showApple)
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              icon: const Icon(Icons.apple),
              label: const Text('Ingresar con Apple'),
              onPressed: () async {
                if (onApplePress == null) return;

                final email = await onApplePress!();
                onSocialResult?.call(email, 'apple');
              },
            ),
          ),
      ],
    );
  }
}