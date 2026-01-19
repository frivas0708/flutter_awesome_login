import 'package:google_sign_in/google_sign_in.dart';

class GoogleService {
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  GoogleSignInAccount? _currentUser;

  /// Retorna el email en caso de éxito, o null si canceló / error.
  Future<String?> signIn() async {
    try {
      // Inicializar (opcional, pero recomendado)
      await _googleSignIn.initialize();
      // Intentar autenticación
      _currentUser = await _googleSignIn.authenticate();
      return _currentUser!.email;
    } catch (_) {
      return null;
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.disconnect();
  }

  // Método adicional para obtener el usuario actual
  GoogleSignInAccount? get currentUser => _currentUser;
}