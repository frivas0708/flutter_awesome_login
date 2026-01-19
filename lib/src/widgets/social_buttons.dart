import 'package:flutter/material.dart';
import '../services/google_service.dart';
import '../services/apple_service.dart';

typedef SocialResult = void Function(String? email, String provider);

class SocialButtons extends StatelessWidget {
  final bool showGoogle;
  final bool showApple;
  final Future<String?> Function()? onGooglePress; // optional override
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
    final googleService = GoogleService();
    final appleService = AppleService();

    return Column(
      children: [
        if (showGoogle)
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              icon: Image.network('https://img.icons8.com/color/48/google-logo.png', width: 20, height: 20),
              label: const Text('Ingresar con Google'),
              onPressed: () async {
                final email = onGooglePress != null ? await onGooglePress!() : await googleService.signIn();
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
                final email = onApplePress != null ? await onApplePress!() : await appleService.signIn();
                onSocialResult?.call(email, 'apple');
              },
            ),
          ),
      ],
    );
  }
}
