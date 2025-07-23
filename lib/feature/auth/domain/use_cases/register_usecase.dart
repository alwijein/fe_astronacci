import 'package:dartz/dartz.dart';
import 'package:fe_astronacci/core/domain/models/error_dto.dart';
import 'package:fe_astronacci/feature/auth/domain/repositories/register_repository.dart';

class RegisterUseCase {
  final RegisterRepository repository;

  RegisterUseCase(this.repository);

  Future<Either<ErrorDto, void>> call({
    required String name,
    required String email,
    required String password,
    String? phone,
  }) =>
      repository.register(
        name: name,
        email: email,
        password: password,
        phone: phone,
      );
}
