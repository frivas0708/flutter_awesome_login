import 'package:flutter/material.dart';

class TwoFactorForm extends StatefulWidget {
  final Future<String?> Function(String code) onVerify;
  final VoidCallback onCancel;
  final String title;
  final String buttonText;

  const TwoFactorForm({
    super.key,
    required this.onVerify,
    required this.onCancel,
    required this.title,
    required this.buttonText,
  });

  @override
  State<TwoFactorForm> createState() => _TwoFactorFormState();
}

class _TwoFactorFormState extends State<TwoFactorForm> {
  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    final error = await widget.onVerify(_codeController.text.trim());
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
          'Ingresa el código de 2 pasos enviado a tu dispositivo.',
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300, width: 1),
            ),
            child: TextFormField(
              controller: _codeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Código',
              ),
              validator: (v) => (v == null || v.isEmpty) ? 'Ingresa el código' : null,
            ),
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
