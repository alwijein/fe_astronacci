import 'package:dartz/dartz.dart';
import 'package:fe_astronacci/core/domain/models/error_dto.dart';
import 'package:fe_astronacci/feature/login/domain/entities/login_entity.dart';
import 'package:fe_astronacci/feature/login/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Either<ErrorDto, LoginEntity>> call({
    required String email,
    required String password,
  }) {
    return repository.login(email: email, password: password);
  }
}
