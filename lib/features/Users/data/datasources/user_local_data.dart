
import 'dart:js_interop';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:inventigacionflutter/core/error/failures.dart';
import 'package:inventigacionflutter/features/Users/data/models/user_model.dart';
import 'package:inventigacionflutter/features/Users/domain/entities/user.dart';

abstract class UserLocalData{
  Future<bool> createUser(User user);
  Future<bool> updateUser(User user);
  Future<bool> deleteUser(int id);
  Future<List<User>> getAllUsers();
  Future<User?> getUserById(int id);
}

class HiveUserLocalDataImpl implements UserLocalData {

  HiveUserLocalDataImpl() {
    Hive.initFlutter();
  }

  @override
  Future<bool> createUser(User user) async{
    try {
      Box<dynamic> userBox = await Hive.openBox('users');

      userBox.put(user.id, UserModel.fromEntity(user).toJson());

      return true;
    } catch (e) {
      throw LocalDatabaseFailure(e.toString());
    }
    //throw UnimplementedError();
  }

  @override
  Future<bool> deleteUser(int id) async{
    try {
      Box<dynamic> userBox = await Hive.openBox('users');
      userBox.delete(id);
      return true;
    } catch (e) {
      throw LocalDatabaseFailure(e.toString());
    }
  }

  @override
  Future<List<User>> getAllUsers() async{
    try {
      Box<dynamic> userBox = await Hive.openBox('users');
      return userBox.values.map((e) => UserModel.fromJson(e)).toList();
    } catch (e) {
      throw LocalDatabaseFailure(e.toString());
    }
  }

  @override
  Future<User?> getUserById(int id) async{
    try {
      Box<dynamic> userBox = await Hive.openBox('users');
      return UserModel.fromJson(userBox.get(id));
    } catch (e) {
      throw LocalDatabaseFailure(e.toString());
      
    }
  }

  @override
  Future<bool> updateUser(User user) async {
    try {
      Box<dynamic> userBox = await Hive.openBox('users');
      if (userBox.containsKey(user.id)){
        userBox.put(user.id, UserModel.fromEntity(user).toJson());
        return true;
      } else {
        throw LocalDatabaseFailure('User not found');
      }
    } catch (e) {
      throw LocalDatabaseFailure(e.toString());
      
    }
  }

}