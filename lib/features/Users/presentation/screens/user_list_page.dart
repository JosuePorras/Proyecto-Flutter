import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventigacionflutter/features/Users/domain/entities/user.dart';
import 'package:inventigacionflutter/features/Users/presentation/bloc/userBloc.dart';
import 'package:inventigacionflutter/features/Users/presentation/bloc/userEvent.dart';
import 'package:inventigacionflutter/features/Users/presentation/bloc/userState.dart';
import 'package:inventigacionflutter/features/Users/presentation/screens/user_form.dart';
import '../widgets/user_card.dart';

class UserListPage extends StatelessWidget {
  const UserListPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final users = [
    //   {
    //     'name': 'Juan Pérez',
    //     'email': 'juan@mail.com',
    //     'gender': 'male',
    //     'status': 'active',
    //   },
    //   {
    //     'name': 'Ana Torres',
    //     'email': 'ana@mail.com',
    //     'gender': 'female',
    //     'status': 'inactive',
    //   },
    // ];

    // Load users from API
    BlocProvider.of<UserBloc>(context).add(FetchUsersEvent());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestión de Usuarios'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: SafeArea(
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UserListSuccessState) {
              return _buildUserList(state.users, context);
            } else if (state is UserErrorState) {
              return Center(child: Text('Error: ${state.failure}'));
            } else {
              return const Center(child: Text('No hay usuarios disponibles.'));
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const UserForm()),
          );
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        icon: const Icon(Icons.person_add),
        label: const Text('Agregar Usuario'),
      ),
    );
  
    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text('Gestión de Usuarios'),
    //     centerTitle: true,
    //     backgroundColor: Theme.of(context).colorScheme.primary,
    //     foregroundColor: Theme.of(context).colorScheme.onPrimary,
    //   ),
    //   body: SafeArea(
    //     child: LayoutBuilder(
    //       builder: (context, constraints) {
    //         return SingleChildScrollView(
    //           padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
    //           child: ConstrainedBox(
    //             constraints: BoxConstraints(
    //               maxWidth: constraints.maxWidth < 500 ? constraints.maxWidth : 500,
    //             ),
    //             child: Container(
    //               padding: const EdgeInsets.all(16),
    //               decoration: BoxDecoration(
    //                 color: Colors.white,
    //                 borderRadius: BorderRadius.circular(16),
    //                 border: Border.all(color: Colors.grey.shade300),
    //                 boxShadow: [
    //                   BoxShadow(
    //                     color: Colors.black.withAlpha((255 * 0.03).round()),
    //                     blurRadius: 4,
    //                     offset: const Offset(0, 2),
    //                   ),
    //                 ],
    //               ),
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   Text(
    //                     'Lista de usuarios registrados',
    //                     style: Theme.of(context).textTheme.titleMedium?.copyWith(
    //                       fontWeight: FontWeight.w600,
    //                       fontSize: 18,
    //                     ),
    //                   ),
    //                   const SizedBox(height: 16),
    //                   ...users.map(
    //                         (user) => UserCard(
    //                       name: user['name']!,
    //                       email: user['email']!,
    //                       gender: user['gender']!,
    //                       status: user['status']!,
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ),
    //         );
    //       },
    //     ),
    //   ),
    //   floatingActionButton: FloatingActionButton.extended(
    //     onPressed: () {
    //       Navigator.pushNamed(context, '/user_form');
    //     },
    //     backgroundColor: Theme.of(context).colorScheme.primary,
    //     foregroundColor: Theme.of(context).colorScheme.onPrimary,
    //     icon: const Icon(Icons.person_add),
    //     label: const Text('Agregar Usuario'),
    //   ),
    // );
  }
  Widget _buildUserList(List<User> users, BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: constraints.maxWidth < 500 ? constraints.maxWidth : 500,
            ),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade300),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha((255 * 0.03).round()),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Lista de usuarios registrados',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                  ),
                  const SizedBox(height: 16),
                  ...users.map(
                    (user) => InkWell(
                      onTap: () {
                        // Opcional: navegar a detalle del usuario
                        context.read<UserBloc>().add(GetUserByIdEvent(id: user.id));
                        Navigator.pushNamed(context, '/user_detail');
                      },
                      child: UserCard(
                        name: user.name,
                        email: user.email,
                        gender: user.gender,
                        status: user.status,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
