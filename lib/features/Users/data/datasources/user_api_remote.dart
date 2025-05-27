import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:inventigacionflutter/core/error/failures.dart';
import 'package:inventigacionflutter/features/Users/data/models/user_model.dart';
import 'package:inventigacionflutter/features/Users/domain/entities/user.dart';

abstract class UserApiRemote {

//Faltan demas funciones del CRUD

  // function to create a user
  Future<User> createUser(User user);
  // function to get a user by id
  Future<User> getUserById(int id);

}

class UserApiRemoteImpl implements UserApiRemote {
  final Dio dio = Dio();
  
  @override
  Future<User> createUser(User user) async{
    final resp = await dio.post('https://gorest.co.in/public/v2/users');
    // Assuming the response is in the format of UserModel
    if (resp.statusCode == 201) {
      return UserModel.fromJson(resp.data);
    } else {
      throw Exception('Failed to create user');
    }
  }
  
  @override
  Future<User> getUserById(int id) async{
    final resp = await dio.get('https://gorest.co.in/public/v2/users/$id');
    if (resp.statusCode == 200) {
      return UserModel.fromJson(resp.data);
    } else {
      throw Exception('Failed to fetch user with id: $id');
    }
    
  }

}