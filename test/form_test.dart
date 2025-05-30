import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inventigacionflutter/features/Users/presentation/bloc/userBloc.dart';
import 'package:inventigacionflutter/features/Users/presentation/bloc/userEvent.dart';
import 'package:inventigacionflutter/features/Users/presentation/screens/user_form.dart';
import 'package:inventigacionflutter/features/Users/domain/entities/user.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';


class FakeAddUserEvent extends Fake implements AddUserEvent {}
class FakeUpdateUserEvent extends Fake implements UpdateUserEvent {}
class MockUserBloc extends Mock implements UserBloc {}

void main() {
  late MockUserBloc mockUserBloc;

  setUpAll(() {//is used in the event of an error when adding or editing in the test
    registerFallbackValue(FakeAddUserEvent());
    registerFallbackValue(FakeUpdateUserEvent());
  });

  setUp(() {
    mockUserBloc = MockUserBloc();
  });

  // Función auxiliar para crear el widget del formulario
  Widget createFormWidget({User? user}) {
    return MaterialApp(
      home: Scaffold(
        body: Provider<UserBloc>.value(
          value: mockUserBloc,
          child: UserForm(user: user),
        ),
      ),
    );
  }

  group('Pruebas del UserForm - Trabajo Flutter:', () {
    testWidgets('Muestra el título correcto para nuevo usuario', (tester) async {
      await tester.pumpWidget(createFormWidget());

      expect(find.text('Agregar Usuario'), findsOneWidget);
    });

    testWidgets('Muestra el título correcto para editar usuario', (tester) async {
      final testUser = User(
        id: 1,
        name: 'Dilan',
        email: 'Dilan@una.com',
        gender: 'male',
        status: 'active',
      );

      await tester.pumpWidget(createFormWidget(user: testUser));

      expect(find.text('Editar Usuario'), findsOneWidget);
    });

    testWidgets('Los campos se inicializan correctamente con datos de usuario', (tester) async {
      final testUser = User(
        id: 1,
        name: 'josue Porras',
        email: 'josue@una.com',
        gender: 'male',
        status: 'inactive',
      );

      await tester.pumpWidget(createFormWidget(user: testUser));

      // verify data
      final nameField = tester.widget<TextFormField>(find.byType(TextFormField).at(0));
          expect((nameField.controller as TextEditingController).text, 'josue Porras');

      final emailField = tester.widget<TextFormField>(find.byType(TextFormField).at(1));
      expect((emailField.controller as TextEditingController).text, 'josue@una.com');
    });

    testWidgets('Validación de campos requeridos', (tester) async {
      await tester.pumpWidget(createFormWidget());

      // send
      await tester.tap(find.text('Guardar'));
      await tester.pump();

      // error messager
      expect(find.text('Requerido'), findsNWidgets(4));
    });

    testWidgets('Validación de formato de email', (tester) async {
      await tester.pumpWidget(createFormWidget());

      // Ingresar email inválido
      await tester.enterText(find.byType(TextFormField).at(1), 'emailinvalido');
      await tester.tap(find.text('Guardar'));
      await tester.pump();

      expect(find.text('Correo inválido'), findsOneWidget);
    });

    testWidgets('Envío de formulario válido para nuevo usuario', (tester) async {
      await tester.pumpWidget(createFormWidget());

      await tester.enterText(find.byType(TextFormField).at(0), 'Yeiler montes');
      await tester.enterText(find.byType(TextFormField).at(1), 'yeiler@una.com');

      await tester.tap(find.text('Género'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Masculino').last);
      await tester.pump();

      await tester.tap(find.text('Estado'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Activo').last);
      await tester.pump();

      // configure mock
      when(() => mockUserBloc.add(any())).thenReturn(null);

      // send
      await tester.tap(find.text('Guardar'));
      await tester.pump();

      verify(() => mockUserBloc.add(
        any(that: isA<AddUserEvent>().having(
              (e) => e.user,
          'user',
          isA<User>()
              .having((u) => u.name, 'name', 'Yeiler montes')
              .having((u) => u.email, 'email', 'yeiler@una.com')
              .having((u) => u.gender, 'gender', 'male')
              .having((u) => u.status, 'status', 'active'),
        )),
      )).called(1);//status
    });

    testWidgets('Envío de formulario válido para editar usuario', (tester) async {
      final testUser = User(
        id: 1,
        name: 'AaronTest',
        email: 'aaron@gmail.com',
        gender: 'male',
        status: 'active',
      );

      await tester.pumpWidget(createFormWidget(user: testUser));

      await tester.enterText(find.byType(TextFormField).at(0), 'Aaron Modificado');
      await tester.enterText(find.byType(TextFormField).at(1), 'aaronM@gmail.com');

      // configure mock
      when(() => mockUserBloc.add(any())).thenReturn(null);

      await tester.tap(find.text('Actualizar'));
      await tester.pump();

      verify(() => mockUserBloc.add(
        any(that: isA<UpdateUserEvent>().having(
              (e) => e.user,
          'user',
          isA<User>()
              .having((u) => u.id, 'id', 1)
              .having((u) => u.name, 'name', 'Aaron Modificado')
              .having((u) => u.email, 'email', 'aaronM@gmail.com')
              .having((u) => u.gender, 'gender', 'male')
              .having((u) => u.status, 'status', 'active'),
        )),
      )).called(1);
    });

    testWidgets('Botón de cancelar cierra el formulario', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Provider<UserBloc>.value(
              value: mockUserBloc,
              child: Builder(
                builder: (context) => ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => UserForm()),
                    );
                  },
                  child: const Text('Open Form'),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open Form'));
      await tester.pumpAndSettle();

      expect(find.byType(UserForm), findsOneWidget);

      await tester.tap(find.text('Cancelar'));
      await tester.pumpAndSettle();

      // Verify form is closed
      expect(find.byType(UserForm), findsNothing);
    });
  });
}