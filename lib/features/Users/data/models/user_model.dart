import 'package:inventigacionflutter/features/Users/domain/entities/user.dart';

class UserModel extends User{ 
  UserModel({required super.id, required super.name, required super.email, required super.gender, required super.status});

// change key in base to match the model 
  factory UserModel.fromJson(json){
    return UserModel(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      gender: json['gender'] as String,
      status: json['status'] as String
    );
  }

// Convert UserModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'gender': gender, 
      'status': status
    };
  }

  factory UserModel.fromEntity(User user){
    return UserModel(id: user.id, name: user.name, email: user.email, gender: user.gender, status: user.status);
  }
}