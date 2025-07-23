import 'package:dio/dio.dart';
import 'package:fe_astronacci/common/utils/local_storage/common_shared_preferences.dart';
import 'package:fe_astronacci/common/utils/local_storage/profile_storage_helper.dart';
import 'package:fe_astronacci/common/utils/network/base_networking.dart';
import 'package:fe_astronacci/feature/auth/data/models/register_model/register_model.dart';
import 'package:fe_astronacci/feature/profile/domain/entities/profile_entity.dart';

abstract class IRegisterRemoteDataSource {
  Future<RegisterResponseModel> register(RegisterRequestModel request);
}

class RegisterRemoteDataSource implements IRegisterRemoteDataSource {
  @override
  Future<RegisterResponseModel> register(RegisterRequestModel request) async {
    final resp = await BaseNetworking.shared.post(
      partUrl: 'register',
      data: request.toJson(),
      isRawData: false,
      contentType: "application/json",
    );

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

    return RegisterResponseModel.fromJson(resp.data['data']);
  }
}
