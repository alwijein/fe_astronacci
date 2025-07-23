import 'package:dartz/dartz.dart';
import 'package:fe_astronacci/core/domain/models/error_dto.dart';
import 'package:fe_astronacci/feature/auth/domain/entities/login_entity.dart';

abstract class AuthRepository {
  Future<Either<ErrorDto, LoginEntity>> login({
    required String email,
    required String password,
  });

  Future<Either<ErrorDto, Unit>> forgotPassword({
    required String email,
  });
}
