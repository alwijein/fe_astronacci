import 'package:dartz/dartz.dart';
import 'package:fe_astronacci/core/domain/models/error_dto.dart';
import 'package:fe_astronacci/feature/profile/domain/entities/profile_entity.dart';

abstract class ProfileRepository {
  Future<Either<ErrorDto, ProfileEntity>> getProfile();
  Future<Either<ErrorDto, ProfileEntity>> updateProfile({
    String? name,
    String? email,
    String? phone,
    String? avatarPath,
  });
}
