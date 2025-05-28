import 'package:flutter/material.dart';

class UserForm extends StatelessWidget {

  static const String ROUTE = "/user_form";
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: Text("Agregar Usuario"),
    ),
      body: Container(child: Text("Prueba"),),
    );
  }
}
