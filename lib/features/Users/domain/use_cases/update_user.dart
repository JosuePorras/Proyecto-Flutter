import 'package:either_dart/either.dart';
import 'package:inventigacionflutter/core/error/failures.dart';
import 'package:inventigacionflutter/features/Users/domain/entities/user.dart';
import 'package:inventigacionflutter/features/Users/domain/repositories/user_repository.dart';

class UpdateUserUseCase {

  final UserRepository userRepository;

  UpdateUserUseCase({required this.userRepository});

  Future<Either<Failure, bool>> call(User user) {
    return userRepository.updateUser(user);
  }
}