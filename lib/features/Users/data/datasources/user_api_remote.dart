import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:inventigacionflutter/core/error/failures.dart';
import 'package:flutter/cupertino.dart';
import 'package:inventigacionflutter/core/error/failures.dart';
import 'package:inventigacionflutter/features/Users/data/models/user_model.dart';
import 'package:inventigacionflutter/features/Users/domain/entities/user.dart';

abstract class UserApiRemote {
  static const String authToken = 'Bearer ea81247968d1a86536d5bc09b5c6c353f9eb7fcebc91a7a409dda4d4f6b20b87';
 //static const String authToken = 
  // function to create a user
  Future<bool> createUser(User user);
  // function to get a user by id
  Future<User> getUserById(int id);
  // function to update a user
  Future<bool> updateUser(User user);
  // function to delete a user
  Future<bool> deleteUser(int id);
  // function to get all users
  Future<List<User>> getAllUsers();
}

class UserApiRemoteImpl implements UserApiRemote {
  /// The auth token for the API requests.
  static const String authToken = UserApiRemote.authToken;
  final Dio dio;

  UserApiRemoteImpl(this.dio) {
    dio.options.baseUrl = 'https://gorest.co.in/public/v2';
    dio.options.connectTimeout = const Duration(seconds: 10);
    dio.options.receiveTimeout = const Duration(seconds: 10);

    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers['Accept'] = 'application/json';
    dio.options.headers['Authorization'] = authToken;
    
    // dio.options.baseUrl = 'https://gorest.co.in/public/v2/';
    // dio.options.headers['Content-Type'] = 'application/json';
    // dio.options.headers['Authorization'] = 'Bearer ea81247968d1a86536d5bc09b5c6c353f9eb7fcebc91a7a409dda4d4f6b20b87';
  }

  @override
  Future<bool> createUser(User user) async {
    try {
      final UserModel userModel = UserModel.fromEntity(user);
      final resp = await dio.post('/users', data: userModel.toJson());
      if (resp.statusCode == 201) {
        return true;
      } else {
        debugPrint('Failed to create user: ${resp.statusCode}');
        return false;
      }
    }catch (e) {
      debugPrint('Error creating user: $e');
      throw ServerFailure('Failed to create user');
    }
  }

  //fetch user by id function
  @override
  Future<User> getUserById(int id) async {
    try {
      final resp = await dio.get('/users/$id');
      if (resp.statusCode == 200) {
        return UserModel.fromJson(resp.data);
      } else {
        throw Exception('Failed to fetch user with id: $id');
      }
    } catch (e) {
      debugPrint('Error fetching user by id: $e');
      throw LocalDatabaseFailure('Failed to fetch user by id');
    }
  }

  //delete user function
  @override
  Future<bool> deleteUser(int id) async {
    try {
      final resp = await dio.delete('/users/$id');
      if (resp.statusCode == 204) {
        return true;
      } else {
        debugPrint('Failed to delete user: ${resp.statusMessage}');
        return false;
      }
    } catch (e) {
      debugPrint('Error deleting user: $e');
      throw LocalDatabaseFailure('Failed to delete user');
      
    }
  }

  //fetch all users function
  @override
  Future<List<User>> getAllUsers() async{
    try {
      final resp = await dio.get('/users');
      if (resp.statusCode == 200){
        return (resp.data as List).map((user) => UserModel.fromJson(user)).toList();
      } else {
        debugPrint('Failed to fetch all users: ${resp.statusCode}');
        return [];
      }
    } catch (e) {
      debugPrint('Error fetching all users: $e');
      throw LocalDatabaseFailure('Failed to fetch all users');
      
    }
  }

  //Update user Function
  @override
  Future<bool> updateUser(User user) async {
    try {
      final UserModel userModel = UserModel.fromEntity(user);
      final resp = await dio.put('/users/${user.id}', data:userModel.toJson());
      if (resp.statusCode == 200){
        return true;
      } else {
        debugPrint('Failed to update user: ${resp.statusCode}');
        return false;
      }
    } catch (e) {
      debugPrint('Error updating user: $e');
      throw LocalDatabaseFailure('Failed to update user');
    }
  }
}
