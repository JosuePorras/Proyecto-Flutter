import 'package:either_dart/either.dart';
import 'package:inventigacionflutter/core/error/failures.dart';
import 'package:inventigacionflutter/features/Users/domain/entities/user.dart';

abstract class UserRepository {
  //function createUser
  Future<Either<Failure, bool>> createUser(User user);
  // function updateUser
  Future<Either<Failure, bool>> updateUser(User user); 
  // function deleteUser
  Future<Either<Failure, bool>> deleteUser(int id);
  // function getAllUsers
  Future<Either<Failure, List<User>>> getAllUsers();
  // function getUserById
  Future<Either<Failure, User>> getUserById(int id);
}