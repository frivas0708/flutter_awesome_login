import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class BiometricButton extends StatefulWidget {
  final String text;
  final Future<void> Function() onAuthenticated;

  const BiometricButton({
    super.key,
    required this.text,
    required this.onAuthenticated,
  });

  @override
  State<BiometricButton> createState() => _BiometricButtonState();
}

class _BiometricButtonState extends State<BiometricButton> {
  final LocalAuthentication auth = LocalAuthentication();
  bool _available = false;

  @override
  void initState() {
    super.initState();
    _checkCanAuthenticate();
  }

  Future<void> _checkCanAuthenticate() async {
    try {
      final can = await auth.canCheckBiometrics;
      final supported = await auth.isDeviceSupported();
      setState(() => _available = can && supported);
    } catch (_) {
      setState(() => _available = false);
    }
  }

  Future<void> _authenticate() async {
    try {
      final didAuthenticate = await auth.authenticate(
        localizedReason: 'Autenticarse con biometría',
        options: const AuthenticationOptions(biometricOnly: true),
      );
      if (didAuthenticate) {
        await widget.onAuthenticated();
      }
    } catch (e) {
      // ignore errors silently, but you can expose callback if needed
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Biometría fallida: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_available) return const SizedBox.shrink();

    return TextButton.icon(
      onPressed: _authenticate,
      icon: const Icon(Icons.fingerprint),
      label: Text(widget.text),
    );
  }
}
