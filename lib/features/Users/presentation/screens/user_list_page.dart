import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventigacionflutter/features/Users/domain/entities/user.dart';
import 'package:inventigacionflutter/features/Users/presentation/bloc/userBloc.dart';
import 'package:inventigacionflutter/features/Users/presentation/bloc/userEvent.dart';
import 'package:inventigacionflutter/features/Users/presentation/bloc/userState.dart';
import 'package:inventigacionflutter/features/Users/presentation/screens/user_form.dart';
import '../widgets/user_card.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  @override
  void initState() {
    super.initState();
    // Cargamos los usuarios al entrar por primera vez
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<UserBloc>().add(FetchUsersEvent());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
              return _buildUserList(state.users);
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
  }

  Widget _buildUserList(List<User> users) {
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
                      onTap: () async {
                        final bloc = context.read<UserBloc>();
                        bloc.add(GetUserByIdEvent(id: user.id));
                        await Navigator.pushNamed(context, '/user_detail');
                        if (mounted) {
                          bloc.add(FetchUsersEvent());
                        }
                      },
                      child: UserCard(
                        id: user.id,
                        name: user.name,
                        email: user.email,
                        gender: user.gender,
                        status: user.status,
                        onDelete: () => _showDeleteDialog(user.name, user.id.toString()),
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

  void _showDeleteDialog(String userName, String userId) {
    final bloc = context.read<UserBloc>();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar eliminación'),
        content: Text('¿Deseas eliminar a $userName?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              bloc.add(DeleteUserEvent(id: int.parse(userId)));
              if (mounted) {
                ScaffoldMessenger.of(this.context).showSnackBar(
                  const SnackBar(content: Text('Usuario eliminado')),
                );
                bloc.add(FetchUsersEvent());
              }
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }
}
