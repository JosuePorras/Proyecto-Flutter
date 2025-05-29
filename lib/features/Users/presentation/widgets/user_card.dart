import 'package:flutter/material.dart';
import 'package:inventigacionflutter/features/Users/presentation/screens/user_form.dart';
import 'package:inventigacionflutter/features/Users/domain/entities/user.dart';

class UserCard extends StatelessWidget {
  final String name;
  final String email;
  final String gender;
  final String status;
  final VoidCallback? onDelete;

  const UserCard({
    super.key,
    required this.name,
    required this.email,
    required this.gender,
    required this.status,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = status.toLowerCase() == 'active';
    final isMale = gender.toLowerCase() == 'male';

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha((255 * 0.1).round()),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 26,
              backgroundColor: colorScheme.primary,
              child: const Icon(Icons.person, color: Colors.white, size: 26),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    email,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurface.withAlpha((255 * 0.7).round()),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: [
                      _buildInfoChip(
                        label: isMale ? 'Masculino' : 'Femenino',
                        background: colorScheme.secondaryContainer,
                        textColor: colorScheme.onSecondaryContainer,
                      ),
                      _buildInfoChip(
                        label: isActive ? 'Activo' : 'Inactivo',
                        background:
                        isActive ? Colors.green.shade100 : Colors.red.shade100,
                        textColor: isActive ? Colors.green : Colors.red,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: colorScheme.primary),
                  onPressed: () {
                    Navigator.pushNamed(context, '/userForm');
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.redAccent),
                  onPressed: onDelete,
                  tooltip: 'Eliminar',
                ),
              ],
            ),
            // IconButton(
            //   icon: Icon(Icons.edit, color: colorScheme.primary),
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (_) => UserForm(
            //           user: User(
            //             id: 1, // Usa el id correcto
            //             name: name,
            //             email: email,
            //             gender: gender,
            //             status: status,
            //           ),
            //         ),
            //       ),
            //     );
            //   },
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip({
    required String label,
    required Color background,
    required Color textColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12.5,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }
}
