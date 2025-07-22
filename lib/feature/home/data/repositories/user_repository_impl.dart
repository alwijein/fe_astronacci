// lib/feature/home/data/repositories/user_repository_impl.dart

import 'package:dartz/dartz.dart';
import 'package:fe_astronacci/common/utils/future/future_util.dart';
import 'package:fe_astronacci/core/domain/models/error_dto.dart';
import 'package:fe_astronacci/feature/home/data/data_sources/network/user_remote_ds.dart';
import 'package:fe_astronacci/feature/home/domain/entities/user_entity.dart';
import 'package:fe_astronacci/feature/home/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final IUserRemoteDataSource remote;

  UserRepositoryImpl(this.remote);

  @override
  Future<Either<ErrorDto, List<UserEntity>>> getUsers({int page = 1}) {
    return FutureUtil.callOrError(
      () async {
        final models = await remote.fetchUsers(page: page);
        return models
            .map((m) => UserEntity(
                  id: m.id,
                  email: m.email,
                  avatar: m.avatar,
                  name: m.name,
                  phone: m.phone,
                ))
            .toList();
      },
    );
  }
}
