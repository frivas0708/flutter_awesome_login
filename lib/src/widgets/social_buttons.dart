import 'package:flutter/material.dart';
import '../models/login_result.dart';
import 'google_button.dart';
import 'apple_button.dart';

typedef SocialResult = void Function(LoginResult result, String provider);

class SocialButtons extends StatelessWidget {
  final bool showGoogle;
  final bool showApple;

  final Future<LoginResult> Function()? onGooglePress;
  final Future<LoginResult> Function()? onApplePress;

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
            child: GoogleButton(
              text: 'Ingresar con Google',
              onPressed: () async {
                if (onGooglePress == null) return;
                final res = await onGooglePress!();
                onSocialResult?.call(res, 'google');
              },
            ),
          ),

        if (showApple && showGoogle) const SizedBox(height: 8),

        if (showApple)
          SizedBox(
            width: double.infinity,
            child: AppleButton(
              text: 'Ingresar con Apple',
              onPressed: () async {
                if (onApplePress == null) return;
                final res = await onApplePress!();
                onSocialResult?.call(res, 'apple');
              },
            ),
          ),
      ],
    );
  }
}