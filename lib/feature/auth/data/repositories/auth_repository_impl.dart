import 'package:dartz/dartz.dart';
import 'package:fe_astronacci/common/utils/future/future_util.dart';
import 'package:fe_astronacci/common/utils/local_storage/common_shared_preferences.dart';
import 'package:fe_astronacci/feature/auth/data/data_sources/network/auth_remote_ds.dart';
import 'package:fe_astronacci/feature/auth/domain/entities/login_entity.dart';
import 'package:fe_astronacci/feature/auth/domain/repositories/auth_repository.dart';
import 'package:fe_astronacci/core/domain/models/error_dto.dart';

class AuthRepositoryImpl implements AuthRepository {
  final IAuthRemoteDataSource remote;

  AuthRepositoryImpl(this.remote);

  @override
  Future<Either<ErrorDto, LoginEntity>> login({
    required String email,
    required String password,
  }) {
    return FutureUtil.callOrError(
      () async {
        final resp = await remote.login(email: email, password: password);

        return LoginEntity(token: resp.accessToken);
      },
      isLoginPage: true,
    );
  }

  @override
  Future<Either<ErrorDto, Unit>> forgotPassword({
    required String email,
  }) {
    return FutureUtil.callOrError(
      () async {
        await remote.forgotPassword(email: email);
        return unit;
      },
    );
  }
}
