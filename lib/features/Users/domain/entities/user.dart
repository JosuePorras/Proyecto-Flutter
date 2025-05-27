class User{
  //Atributtes
  final String id;
  final String name;
  final String email;
  final String gender;
  final String status;

  //Constructor
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.gender,
    required this.status,
  });


  @override
  String toString() {
    return 'User{id: $id, name: $name, email: $email, gender: $gender, status: $status}';
  }
}