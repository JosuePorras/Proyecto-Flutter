import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:inventigacionflutter/features/Users/data/repositories/users_repository_impl.dart';
import 'package:inventigacionflutter/features/Users/domain/entities/user.dart';
import 'package:inventigacionflutter/core/error/failures.dart';
import 'package:inventigacionflutter/features/Users/data/datasources/user_api_remote.dart';

// Generate mocks with build_runner
@GenerateMocks([UserApiRemote])
import 'user_repository_test.mocks.dart';

void main() {
  late UsersRepositoryImpl repository;
  late MockUserApiRemote mockApi;

  setUp(() {
    mockApi = MockUserApiRemote();
    repository = UsersRepositoryImpl(userApiRemote: mockApi);
  });

  final testUser = User(
      id: 1,
      name: 'Juan',
      email: 'juan@email.com',
      gender: 'male',
      status: 'active'
  );

  final updatedUser = User(
      id: 1,
      name: 'Juan Updated',
      email: 'juan.updated@email.com',
      gender: 'male',
      status: 'inactive'
  );

  final userList = [
    testUser,
    User(
        id: 2,
        name: 'Maria',
        email: 'maria@email.com',
        gender: 'female',
        status: 'active'
    )
  ];

  group('Operaciones CRUD', () {
    // CREATE
    group('createUser', () {
      test('debería retornar True al crear un usuario exitosamente', () async {
        // Arrange
        when(mockApi.createUser(testUser)).thenAnswer((_) async => true);

        // Act
        final result = await repository.createUser(testUser);

        // Assert
        expect(result.isRight, true);
        expect(result.right, true);
        verify(mockApi.createUser(testUser)).called(1);
      });

    });

    // READ
    group('getAllUsers', () {
      test('debería retornar una lista de usuarios cuando la llamada es exitosa', () async {
        // Arrange
        when(mockApi.getAllUsers()).thenAnswer((_) async => userList);

        // Act
        final result = await repository.getAllUsers();

        // Assert
        expect(result.isRight, true);
        expect(result.right, userList);
        verify(mockApi.getAllUsers()).called(1);
      });

    });

    group('getUserById', () {
      test('debería retornar un usuario cuando se encuentra por ID', () async {
        // Arrange
        when(mockApi.getUserById(1)).thenAnswer((_) async => testUser);

        // Act
        final result = await repository.getUserById(1);

        // Assert
        expect(result.isRight, true);
        expect(result.right, testUser);
        verify(mockApi.getUserById(1)).called(1);
      });

    });

    // UPDATE
    group('updateUser', () {
      test('debería retornar true al actualizar un usuario exitosamente', () async {
        // Arrange
        when(mockApi.updateUser(updatedUser)).thenAnswer((_) async => true);

        // Act
        final result = await repository.updateUser(updatedUser);

        // Assert
        expect(result.isRight, true);
        expect(result.right, true);
        verify(mockApi.updateUser(updatedUser)).called(1);
      });

    });

    // DELETE
    group('deleteUser', () {
      test('debería retornar true al eliminar un usuario exitosamente', () async {
        // Arrange
        when(mockApi.deleteUser(1)).thenAnswer((_) async => true);

        // Act
        final result = await repository.deleteUser(1);

        // Assert
        expect(result.isRight, true);
        expect(result.right, true);
        verify(mockApi.deleteUser(1)).called(1);
      });

    });
  });
}