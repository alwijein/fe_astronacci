import 'package:dartz/dartz.dart';
import 'package:fe_astronacci/core/domain/models/error_dto.dart';

abstract class RegisterRepository {
  Future<Either<ErrorDto, void>> register({
    required String name,
    required String email,
    required String password,
    String? phone,
  });
}
