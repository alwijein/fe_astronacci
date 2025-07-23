import 'package:dartz/dartz.dart';
import 'package:fe_astronacci/common/utils/future/future_util.dart';
import 'package:fe_astronacci/feature/auth/data/data_sources/network/register_remote_ds.dart';
import 'package:fe_astronacci/core/domain/models/error_dto.dart';
import 'package:fe_astronacci/feature/auth/data/models/register_model/register_model.dart';
import 'package:fe_astronacci/feature/auth/domain/repositories/register_repository.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  final IRegisterRemoteDataSource remote;

  RegisterRepositoryImpl(this.remote);

  @override
  Future<Either<ErrorDto, void>> register({
    required String name,
    required String email,
    required String password,
    String? phone,
  }) {
    return FutureUtil.callOrError(
      () async {
        final request = RegisterRequestModel(
          name: name,
          email: email,
          password: password,
          phone: phone,
        );

        await remote.register(request);
        return;
      },
    );
  }
}
