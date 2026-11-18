import 'package:flutter/material.dart';

class ChangePasswordForm extends StatefulWidget {
  final Future<String?> Function(String newPassword) onChangePassword;
  final VoidCallback onCancel;
  final String title;
  final String buttonText;
  final String newPasswordHintText;
  final String confirmPasswordHintText;

  const ChangePasswordForm({
    super.key,
    required this.onChangePassword,
    required this.onCancel,
    required this.title,
    required this.buttonText,
    this.newPasswordHintText = 'Nueva contraseña',
    this.confirmPasswordHintText = 'Confirmar contraseña',
  });

  @override
  State<ChangePasswordForm> createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final _pass1 = TextEditingController();
  final _pass2 = TextEditingController();
  bool _loading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _pass1.dispose();
    _pass2.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    final error = await widget.onChangePassword(_pass1.text);
    setState(() => _loading = false);

    if (error != null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(backgroundColor: Colors.red, content: Text(error)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(widget.title, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 16),
        const Text(
          'Debes cambiar tu contraseña temporal.',
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300, width: 1),
                ),
                child: TextFormField(
                  controller: _pass1,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: widget.newPasswordHintText,
                    suffixIcon: IconButton(
                      tooltip: _obscurePassword
                          ? 'Mostrar contraseña'
                          : 'Ocultar contraseña',
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                  validator: (v) => (v == null || v.length < 6)
                      ? 'Mínimo 6 caracteres'
                      : null,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300, width: 1),
                ),
                child: TextFormField(
                  controller: _pass2,
                  obscureText: _obscureConfirmPassword,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: widget.confirmPasswordHintText,
                    suffixIcon: IconButton(
                      tooltip: _obscureConfirmPassword
                          ? 'Mostrar contraseña'
                          : 'Ocultar contraseña',
                      icon: Icon(
                        _obscureConfirmPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        });
                      },
                    ),
                  ),
                  validator: (v) {
                    if (v != _pass1.text) return 'Las contraseñas no coinciden';
                    return null;
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 20),
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: _loading ? null : _submit,
            child: _loading
                ? const CircularProgressIndicator()
                : Text(widget.buttonText),
          ),
        ),
        const SizedBox(height: 14),
        TextButton(
          onPressed: _loading ? null : widget.onCancel,
          child: const Text('Cancelar'),
        ),
      ],
    );
  }
}
