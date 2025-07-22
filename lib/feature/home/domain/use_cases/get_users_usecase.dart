import 'package:dartz/dartz.dart';
import 'package:fe_astronacci/core/domain/models/error_dto.dart';
import 'package:fe_astronacci/feature/home/domain/entities/user_entity.dart';
import 'package:fe_astronacci/feature/home/domain/repositories/user_repository.dart';

class GetUsersUseCase {
  final UserRepository repository;

  GetUsersUseCase(this.repository);

  Future<Either<ErrorDto, List<UserEntity>>> call({int page = 1}) =>
      repository.getUsers(page: page);
}
