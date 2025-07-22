import 'package:dartz/dartz.dart';
import 'package:fe_astronacci/core/domain/models/error_dto.dart';
import 'package:fe_astronacci/feature/profile/domain/entities/profile_entity.dart';
import 'package:fe_astronacci/feature/profile/domain/repositories/profile_repository.dart';

class GetProfileUseCase {
  final ProfileRepository repository;

  GetProfileUseCase(this.repository);

  Future<Either<ErrorDto, ProfileEntity>> call() {
    return repository.getProfile();
  }
}
