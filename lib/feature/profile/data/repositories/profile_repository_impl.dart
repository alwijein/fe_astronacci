import 'package:fe_astronacci/feature/profile/data/data_sources/network/profile_remote_ds.dart';
import 'package:fe_astronacci/feature/profile/domain/entities/profile_entity.dart';
import 'package:fe_astronacci/feature/profile/domain/repositories/profile_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:fe_astronacci/core/domain/models/error_dto.dart';
import 'package:fe_astronacci/common/utils/future/future_util.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final IProfileRemoteDataSource remote;

  ProfileRepositoryImpl(this.remote);

  @override
  Future<Either<ErrorDto, ProfileEntity>> getProfile() {
    return FutureUtil.callOrError(() => remote.getProfile());
  }

  @override
  Future<Either<ErrorDto, ProfileEntity>> updateProfile({
    String? name,
    String? email,
    String? phone,
    String? avatarPath,
  }) {
    return FutureUtil.callOrError(() => remote.updateProfile(
          name: name,
          email: email,
          phone: phone,
          avatarPath: avatarPath,
        ));
  }
}
