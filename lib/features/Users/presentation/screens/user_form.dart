import 'package:flutter/material.dart';
import 'package:inventigacionflutter/features/Users/domain/entities/user.dart';

class UserForm extends StatefulWidget {
  static const route = '/user_form';
  final User? user;

  const UserForm({Key? key, this.user}) : super(key: key);

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _genderController;
  late TextEditingController _statusController;

  @override
  void initState() {
    super.initState();


    _nameController = TextEditingController(text: widget.user?.name ?? '');
    _emailController = TextEditingController(text: widget.user?.email ?? '');
    _genderController = TextEditingController(text: widget.user?.gender ?? '');
    _statusController = TextEditingController(text: widget.user?.status ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _genderController.dispose();
    _statusController.dispose();
    super.dispose();
  }

  void _saveForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final newUser = User(
        id: widget.user?.id ?? DateTime.now().millisecondsSinceEpoch,
        name: _nameController.text,
        email: _emailController.text,
        gender: _genderController.text,
        status: _statusController.text,
      );

      Navigator.of(context).pop(newUser);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.user != null;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Agregar Usuario'),
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
        ),
        body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
          key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Nombre'),
                  validator: (value) => value!.isEmpty ? 'Requerido' : null,
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Correo'),
                  validator: (value) => value!.isEmpty ? 'Requerido' : null,
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _genderController,
                  decoration: const InputDecoration(labelText: 'Género'),
                  validator: (value) => value!.isEmpty ? 'Requerido' : null,
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _statusController,
                  decoration: const InputDecoration(labelText: 'Estado'),
                  validator: (value) => value!.isEmpty ? 'Requerido' : null,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      child: const Text('Cancelar'),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      child: Text(isEditing ? 'Actualizar' : 'Guardar'),
                      onPressed: _saveForm,
                    ),
                  ],

                ),
              ],
            ),
            ),
        );
    }
}