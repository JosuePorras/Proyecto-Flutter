
//abstract class that defines the structure for different types of failures in the application.
abstract class Failure {}

class ServerFailure extends Failure {
  final String message;

  ServerFailure(this.message);
}

class LocalDatabaseFailure extends Failure {
  final String message;

  LocalDatabaseFailure(this.message);
}