import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

// General failures
class ServerFailure extends Failure {
  final String? message;

  ServerFailure({
    this.message,
  });

  @override
  List<Object?> get props => [message];
}

class CacheFailure extends Failure {
  final String? message;

  CacheFailure({
    this.message,
  });

  @override
  List<Object?> get props => [message];
}

class InternetFailure extends Failure {
  final String? message;

  InternetFailure({
    this.message,
  });

  @override
  List<Object?> get props => [message];
}
