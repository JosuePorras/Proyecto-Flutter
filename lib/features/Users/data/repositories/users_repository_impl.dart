import 'package:either_dart/src/either.dart';
import 'package:inventigacionflutter/core/error/failures.dart';
import 'package:inventigacionflutter/features/Users/data/datasources/user_api_remote.dart';
import 'package:inventigacionflutter/features/Users/data/datasources/user_local_data.dart';
import 'package:inventigacionflutter/features/Users/domain/entities/user.dart';
import 'package:inventigacionflutter/features/Users/domain/repositories/user_repository.dart';

class UsersRepositoryImpl implements UserRepository {
  
  //dependencies
  final UserApiRemote userApiRemote;
  final UserLocalData userLocalData;
  
  //constructor
  UsersRepositoryImpl({
    required this.userApiRemote,
    required this.userLocalData
  });

  @override
  Future<Either<Failure, bool>> createUser(User user) async{
    try {
      final bool res = await userLocalData.createUser(user);
      return Right(res);
    } on LocalDatabaseFailure {
      return Left(LocalDatabaseFailure('Failed to create user in local database'));
    }

    // try {
    //   final bool res = await userApiRemote.createUser(user);
    //   return Right(res);
    // } on LocalDatabaseFailure {
    //   return Left(LocalDatabaseFailure('Failed to create user in local database'));
    // }
  }

  @override
  Future<Either<Failure, bool>> deleteUser(int id) {
    // TODO: implement deleteUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<User>>> getAllUsers() async{
    try {
      final List<User> res = await userLocalData.getAllUsers();
      return Right(res);
    } on LocalDatabaseFailure {
      return Left(LocalDatabaseFailure('Failed to fetch all users in local database'));
    }
  }

  @override
  Future<Either<Failure, User>> getUserById(int id) {
    // TODO: implement getUserById
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> updateUser(User user) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }

}