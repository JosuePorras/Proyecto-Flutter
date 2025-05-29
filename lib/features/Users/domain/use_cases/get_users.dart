import 'package:either_dart/either.dart';
import 'package:inventigacionflutter/core/error/failures.dart';
import 'package:inventigacionflutter/features/Users/domain/entities/user.dart';
import 'package:inventigacionflutter/features/Users/domain/repositories/user_repository.dart';

class GetAllUsersUseCase {
  /// Use case for retrieving all users.
  final UserRepository userRepository;

  GetAllUsersUseCase({required this.userRepository});

  Future<Either<Failure, List<User>>> call() {
    return userRepository.getAllUsers();
  }
}