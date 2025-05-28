import 'package:either_dart/either.dart';
import 'package:inventigacionflutter/core/error/failures.dart';
import 'package:inventigacionflutter/features/Users/domain/repositories/user_repository.dart';

class UserDeleteUseCase {

  final UserRepository userRepository;

  UserDeleteUseCase({required this.userRepository});

  Future<Either<Failure, bool>> call(int id){
    return userRepository.deleteUser(id);
  }

}