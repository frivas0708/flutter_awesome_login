// Nota: sign_in_with_apple debe ser añadida por la app que utilice el paquete.
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AppleService {
  Future<String?> signIn() async {
    try {
      final cred = await SignInWithApple.getAppleIDCredential(
        scopes: [AppleIDAuthorizationScopes.email, AppleIDAuthorizationScopes.fullName],
      );
      return cred.email ?? cred.userIdentifier;
    } catch (_) {
      return null;
    }
  }
}
