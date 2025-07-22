import 'package:fe_astronacci/feature/profile/domain/entities/profile_entity.dart';
import 'package:fe_astronacci/feature/profile/domain/repositories/profile_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:fe_astronacci/core/domain/models/error_dto.dart';

class UpdateProfileUseCase {
  final ProfileRepository repository;

  UpdateProfileUseCase(this.repository);

  Future<Either<ErrorDto, ProfileEntity>> call({
    String? name,
    String? email,
    String? phone,
    String? avatarPath,
  }) {
    return repository.updateProfile(
      name: name,
      email: email,
      phone: phone,
      avatarPath: avatarPath,
    );
  }
}
