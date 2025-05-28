import 'dart:isolate';

import 'package:dio/dio.dart';
import 'package:either_dart/src/either.dart';
import 'package:inventigacionflutter/core/error/failures.dart';
import 'package:inventigacionflutter/features/Users/data/datasources/user_api_remote.dart';
import 'package:inventigacionflutter/features/Users/data/datasources/user_local_data.dart';
import 'package:inventigacionflutter/features/Users/domain/entities/user.dart';
import 'package:inventigacionflutter/features/Users/domain/repositories/user_repository.dart';

class UsersRepositoryImpl implements UserRepository {
  
  //dependencies
  final UserApiRemote userApiRemote;
  //final UserLocalData userLocalData;
  
  //constructor
  UsersRepositoryImpl({
    required this.userApiRemote,
    /*required this.userLocalData*/
  });

  @override
  Future<Either<Failure, bool>> createUser(User user) async{
    try {
      final bool res = await userApiRemote.createUser(user);
      return Right(res);
    } on DioException{
      return Left(ServerFailure('Failed to create user in local database'));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteUser(int id) async{
    try {
      final bool res = await userApiRemote.deleteUser(id);
      return Right(res);
    } on DioException {
      return Left(ServerFailure('Failed to delete user in local database'));
    }
  }

  @override
  Future<Either<Failure, List<User>>> getAllUsers() async{
    try {
      final List<User> res = await userApiRemote.getAllUsers();
      return Right(res);
    } on DioException {
      return Left(ServerFailure('Failed to fetch all users in local database'));
    }
  }

  @override
  Future<Either<Failure, User>> getUserById(int id) async{
    try {
      final User res = await userApiRemote.getUserById(id);
      return Right(res);
    } on DioException {
      return Left(ServerFailure('Failed to Delete User'));
    }
  }

  @override
  Future<Either<Failure, bool>> updateUser(User user) async {
    try {
      final bool res = await userApiRemote.updateUser(user);
      return Right(res);
    } on DioException {
      return Left(ServerFailure('Failed to update user in database'));
    }
  }

}