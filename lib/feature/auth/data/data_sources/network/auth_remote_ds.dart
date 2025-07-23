import 'package:fe_astronacci/common/utils/local_storage/common_shared_preferences.dart';
import 'package:fe_astronacci/common/utils/local_storage/profile_storage_helper.dart';
import 'package:fe_astronacci/common/utils/logging/common_log.dart';
import 'package:fe_astronacci/common/utils/network/base_networking.dart';
import 'package:fe_astronacci/feature/auth/data/models/login_response/login_response.dart';
import 'package:fe_astronacci/feature/profile/domain/entities/profile_entity.dart';

abstract class IAuthRemoteDataSource {
  Future<LoginResponse> login({
    required String email,
    required String password,
  });

  Future<void> forgotPassword({required String email});
}

class AuthRemoteDataSource implements IAuthRemoteDataSource {
  @override
  Future<LoginResponse> login({
    required String email,
    required String password,
  }) async {
    final resp = await BaseNetworking.shared.post<Map<String, dynamic>>(
      partUrl: 'login',
      contentType: "application/json",
      bodyParams: {
        "email": email,
        "password": password,
      },
    );
    Log.debug('Data source login response: ${resp.data['data']}');

    final data = resp.data['data']['user'];

    final entity = ProfileEntity(
      id: data['id'],
      name: data['name'],
      email: data['email'],
      phone: data['phone'],
      avatar: data['avatar'],
    );

    await ProfileStorageHelper.saveProfile(entity);

    CommonSharedPreferences.shared.save<String>(
      CommonSharedPreferences.headerTokenKey,
      resp.data['data']['access_token'],
    );

    return LoginResponse.fromJson(resp.data['data']);
  }

  @override
  Future<void> forgotPassword({required String email}) async {
    final resp = await BaseNetworking.shared.post<Map<String, dynamic>>(
      partUrl: 'forgot-password',
      contentType: "application/json",
      bodyParams: {
        "email": email,
      },
    );
    Log.debug('Data source forgot password response: ${resp.data}');
  }
}
