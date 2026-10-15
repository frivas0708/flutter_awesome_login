class LoginResult {
  final bool success;
  final String? errorMessage;
  final bool requires2FA;
  final bool requiresPasswordChange;

  const LoginResult({
    this.success = false,
    this.errorMessage,
    this.requires2FA = false,
    this.requiresPasswordChange = false,
  });
}
