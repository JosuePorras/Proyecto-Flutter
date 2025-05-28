import 'package:flutter/material.dart';
import '../../../../app/routes/app_routes.dart';

class AddUserButton extends StatelessWidget {
  const AddUserButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        Navigator.pushNamed(context, AppRoutes.userForm);
      },
      icon: const Icon(Icons.person_add),
      label: const Text('Agregar Usuario'),
    );
  }
}