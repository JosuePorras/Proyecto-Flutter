
import 'package:hive_flutter/hive_flutter.dart';
import 'package:inventigacionflutter/core/error/failures.dart';
import 'package:inventigacionflutter/features/Users/data/models/user_model.dart';
import 'package:inventigacionflutter/features/Users/domain/entities/user.dart';

abstract class UserLocalData{
  Future<bool> createUser(User user);
  Future<bool> updateUser(User user);
  Future<bool> deleteUser(String id);
  Future<List<User>> getAllUsers();
  Future<User?> getUserById(String id);
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
  Future<bool> deleteUser(String id) {
    // TODO: implement deleteUser
    throw UnimplementedError();
  }

  @override
  Future<List<User>> getAllUsers() {
    // TODO: implement getAllUsers
    throw UnimplementedError();
  }

  @override
  Future<User?> getUserById(String id) {
    // TODO: implement getUserById
    throw UnimplementedError();
  }

  @override
  Future<bool> updateUser(User user) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }

}