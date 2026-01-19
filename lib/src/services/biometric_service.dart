import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class BiometricService {
  final LocalAuthentication _auth = LocalAuthentication();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  static const String _tokenKey = "auth_token";

  /// Guarda el token después del login normal
  Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  /// Borra el token (logout)
  Future<void> clearToken() async {
    await _storage.delete(key: _tokenKey);
  }

  /// Obtiene el token guardado
  Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  /// Verifica si la biometría está disponible en el dispositivo
  Future<bool> canCheckBiometrics() async {
    try {
      return await _auth.canCheckBiometrics;
    } catch (_) {
      return false;
    }
  }

  /// Verifica si el dispositivo soporta biometría
  Future<bool> isDeviceSupported() async {
    try {
      return await _auth.isDeviceSupported();
    } catch (_) {
      return false;
    }
  }

  /// Verifica si existen credenciales válidas en el storage
  Future<bool> hasStoredCredentials() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  /// Confirma si se puede ofrecer el botón "Acceder con biometría"
  Future<bool> canUseBiometricLogin() async {
    final bioAvailable = await canCheckBiometrics();
    final deviceSupported = await isDeviceSupported();
    final hasCredentials = await hasStoredCredentials();

    return bioAvailable && deviceSupported && hasCredentials;
  }

  /// Ejecuta la autenticación biométrica
  Future<bool> authenticate({
    String localizedReason = 'Confirma tu identidad',
    bool allowDevicePasscode = false,
  }) async {
    try {
      final canUse = await canUseBiometricLogin();
      if (!canUse) {
        return false;
      }

      return await _auth.authenticate(
        localizedReason: localizedReason,
        options: AuthenticationOptions(
          biometricOnly: !allowDevicePasscode,
          stickyAuth: true,
          useErrorDialogs: true,
        ),
      );
    } on PlatformException catch (e) {
      // Manejo de errores conocidos
      if (e.code == "LockedOut" || e.code == "PermanentlyLockedOut") {
        return false;
      }
      return false;
    } catch (_) {
      return false;
    }
  }
}
