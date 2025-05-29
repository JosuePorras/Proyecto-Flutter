import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventigacionflutter/features/Users/presentation/bloc/userBloc.dart';
import 'package:inventigacionflutter/features/Users/presentation/bloc/userState.dart';

class UserDetailPage extends StatelessWidget {
  const UserDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle de Usuario'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: SafeArea(
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UserSuccessState) {
              final user = state.user;
              final isActive = user.status.toLowerCase() == 'active';
              final isMale = user.gender.toLowerCase() == 'male';
              final colorScheme = Theme.of(context).colorScheme;

              return Center(
                child: Card(
                  margin: const EdgeInsets.all(16),
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 28,
                              backgroundColor: colorScheme.primary,
                              child: const Icon(Icons.person, color: Colors.white, size: 30),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                user.name,
                                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        _infoRow(Icons.email, "Email", user.email),
                        _infoRow(Icons.person, "Género", isMale ? 'Masculino' : 'Femenino'),
                        _infoRow(
                          Icons.verified_user,
                          "Estado",
                          isActive ? 'Activo' : 'Inactivo',
                          color: isActive ? Colors.green : Colors.red,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else if (state is UserErrorState) {
              return Center(child: Text('Error: ${state.failure}'));
            } else {
              return const Center(child: Text('Seleccione un usuario para ver detalles'));
            }
          },
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 20, color: color ?? Colors.grey[700]),
          const SizedBox(width: 8),
          Text(
            '$label: ',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          Expanded(
            child: Text(value, style: TextStyle(color: color)),
          ),
        ],
      ),
    );
  }
}
