import 'package:either_dart/either.dart';
import 'package:inventigacionflutter/core/error/failures.dart';
import 'package:inventigacionflutter/features/Users/domain/entities/user.dart';
import 'package:inventigacionflutter/features/Users/domain/repositories/user_repository.dart';

class GetUserByIdUseCase {
  final UserRepository userRepository;

  GetUserByIdUseCase({required this.userRepository});

  Future<Either<Failure, User>> call(int id){
    return userRepository.getUserById(id);
  }

}