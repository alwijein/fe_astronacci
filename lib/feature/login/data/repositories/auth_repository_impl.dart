import 'package:dartz/dartz.dart';
import 'package:fe_astronacci/common/utils/future/future_util.dart';
import 'package:fe_astronacci/common/utils/local_storage/common_shared_preferences.dart';
import 'package:fe_astronacci/feature/login/data/data_sources/network/auth_remote_ds.dart';
import 'package:fe_astronacci/feature/login/domain/entities/login_entity.dart';
import 'package:fe_astronacci/feature/login/domain/repositories/auth_repository.dart';
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
        // set token to shared preferences
        CommonSharedPreferences.shared.save<String>(
          CommonSharedPreferences.headerTokenKey,
          resp.accessToken,
        );
        return LoginEntity(token: resp.accessToken);
      },
      isLoginPage: true,
    );
  }
}
