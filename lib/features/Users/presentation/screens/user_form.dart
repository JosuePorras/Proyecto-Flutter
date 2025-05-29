import 'package:flutter/material.dart';
import 'package:inventigacionflutter/features/Users/data/models/user_model.dart';
import 'package:inventigacionflutter/features/Users/domain/entities/user.dart';
import 'package:inventigacionflutter/features/Users/presentation/bloc/userBloc.dart';
import 'package:inventigacionflutter/features/Users/presentation/bloc/userEvent.dart';
import 'package:provider/provider.dart';

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
        id: widget.user?.id ?? 0,
        name: _nameController.text,
        email: _emailController.text,
        gender: _genderController.text,
        status: _statusController.text,
      );

      debugPrint('Saving user: $newUser, ID: ${newUser.id}');
      final userBloc = context.read<UserBloc>();

      //if updating an existing user
      if (newUser.id != 0) {
        userBloc.add(UpdateUserEvent(user: newUser));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Usuario actualizado exitosamente')),
        );
      } else {
        //Adding a new user
        userBloc.add(AddUserEvent(user: newUser));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Usuario Registrado exitosamente')),
        );
      }

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.user != null;
    print('isEditing: $isEditing');

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Editar Usuario' : 'Agregar Usuario'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
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
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Requerido';
                  }
                  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                  if (!emailRegex.hasMatch(value)) {
                    return 'Correo inválido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _genderController.text.isNotEmpty ? _genderController.text : null,
                decoration: const InputDecoration(labelText: 'Género'),
                items: const [
                  DropdownMenuItem(value: 'male', child: Text('Masculino')),
                  DropdownMenuItem(value: 'female', child: Text('Femenino')),
                ],
                onChanged: (value) {
                  _genderController.text = value!;
                },
                validator: (value) => value == null || value.isEmpty ? 'Requerido' : null,
              ),
              const SizedBox(height: 8),

              DropdownButtonFormField<String>(
                value: _statusController.text.isNotEmpty ? _statusController.text : null,
                decoration: const InputDecoration(labelText: 'Estado'),
                items: const [
                  DropdownMenuItem(value: 'active', child: Text('Activo')),
                  DropdownMenuItem(value: 'inactive', child: Text('Inactivo')),
                ],
                onChanged: (value) {
                  _statusController.text = value!;
                },
                validator: (value) => value == null || value.isEmpty ? 'Requerido' : null,
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
                    onPressed: _saveForm,
                    child: Text(isEditing ? 'Actualizar' : 'Guardar'),

                    // onPressed: () {
                    //   if (_formKey.currentState?.validate() ?? false) {
                    //     final newUser = User(
                    //       id: widget.user?.id ?? 0,
                    //       name: _nameController.text,
                    //       email: _emailController.text,
                    //       gender: _genderController.text,
                    //       status: _statusController.text,
                    //     );
                    //     //Add Event to Bloc
                    //     context.read<UserBloc>().add(AddUserEvent(user: newUser));
                    //     //Success message
                    //     ScaffoldMessenger.of(context).showSnackBar(
                    //       const SnackBar(
                    //         content: Text("Usuario guardado exitosamente"),
                    //       ),
                    //     );
                    //     //Navigate back
                    //     Navigator.of(context).pop();
                    //   }
                    // },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
