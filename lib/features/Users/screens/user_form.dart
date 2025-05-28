import 'package:flutter/material.dart';

class UserForm extends StatelessWidget {
  static const route = '/user_form';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Agregar usuario', style: Theme.of(context).textTheme.titleLarge),
        TextFormField(
          decoration: InputDecoration(labelText: 'Nombre'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Correo'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Genero'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Estado'),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              child: Text('Guardar'),
              onPressed: () {
                // guardar usuario
                Navigator.of(context).pop();
              },
            ),
          ],
        )
      ],
    );
  }
}
