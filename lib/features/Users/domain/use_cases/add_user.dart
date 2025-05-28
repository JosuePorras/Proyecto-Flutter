import 'package:either_dart/either.dart';
import 'package:inventigacionflutter/core/error/failures.dart';
import 'package:inventigacionflutter/features/Users/domain/entities/user.dart';
import 'package:inventigacionflutter/features/Users/domain/repositories/user_repository.dart';

class AddUserUseCase {
  final UserRepository userRepository;

  AddUserUseCase({required this.userRepository});

  Future<Either<Failure, bool>>call(User user){
    return userRepository.createUser(user);
  }
}