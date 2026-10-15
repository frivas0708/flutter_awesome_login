# CHANGELOG

## 1.0.3

- Added `onCustomRegister` callback to `AwesomeLoginConfig` to support external onboarding and custom registration wizards.
- Added custom title options for 2FA, password change, and password recovery.
- Fixed deprecation warnings for `withValues(alpha: ...)`.
- Cleaned up lint rules and improved documentation for pub.dev release.

## 1.0.2

- Refactored architecture to make the package completely standalone and reusable across multiple applications.
- Removed hardcoded project dependencies.

## 1.0.1

- Switched to smooth animated flip cards for login, registration, and password recovery.

## 1.0.0

- Initial release:
  - Responsive animated authentication component.
  - Built-in input validations.
  - Biometric authentication via `local_auth`.
  - Optional Google and Apple Sign-In support.
  - Two-Factor Authentication (2FA) verification form.
  - Example app included.
