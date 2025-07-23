import 'package:dartz/dartz.dart';
import 'package:fe_astronacci/core/domain/models/error_dto.dart';
import 'package:fe_astronacci/feature/home/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<Either<ErrorDto, List<UserEntity>>> getUsers(
      {int page = 1, String? search});
}
