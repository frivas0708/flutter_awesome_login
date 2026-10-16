import 'package:flutter/material.dart';

class ForgotPasswordForm extends StatefulWidget {
  final Future<String?> Function(String email) onRecover;
  final VoidCallback onSwitchLogin;
  final VoidCallback? onEnterResetCode;
  final String title;
  final String buttonText;

  const ForgotPasswordForm({
    super.key,
    required this.onRecover,
    required this.onSwitchLogin,
    this.onEnterResetCode,
    this.title = 'Recuperar Contraseña',
    this.buttonText = 'Enviar',
  });

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    final res = await widget.onRecover(_email.text.trim());
    setState(() => _loading = false);
    if (res != null) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(res)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 12),
        Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(255, 255, 255, 1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300, width: 1),
                ),
                child: TextFormField(
                  controller: _email,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Email',
                  ),
                  validator: (v) =>
                      (v == null || !v.contains('@')) ? 'Email inválido' : null,
                ),
              ),

              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _loading ? null : _submit,
                  child: _loading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text(widget.buttonText),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        if (widget.onEnterResetCode != null) ...[
          TextButton(
            onPressed: widget.onEnterResetCode,
            child: const Text('¿Ya tienes un código? Ingresar código'),
          ),
        ],
        TextButton(
          onPressed: widget.onSwitchLogin,
          child: const Text('Volver al login'),
        ),
      ],
    );
  }
}
