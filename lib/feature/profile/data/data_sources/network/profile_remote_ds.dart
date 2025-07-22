import 'dart:io';
import 'package:dio/dio.dart';
import 'package:fe_astronacci/common/utils/local_storage/profile_storage_helper.dart';
import 'package:fe_astronacci/common/utils/logging/common_log.dart';
import 'package:fe_astronacci/common/utils/network/base_networking.dart';
import 'package:fe_astronacci/feature/profile/domain/entities/profile_entity.dart';

abstract class IProfileRemoteDataSource {
  Future<ProfileEntity> getProfile();
  Future<ProfileEntity> updateProfile({
    String? name,
    String? email,
    String? phone,
    String? avatarPath,
  });
}

class ProfileRemoteDataSource implements IProfileRemoteDataSource {
  @override
  Future<ProfileEntity> getProfile() async {
    final resp = await ProfileStorageHelper.getProfile();
    final data = resp;

    Log.debug('Data source getProfile response: ${data!.name}');

    final entity = ProfileEntity(
      id: data.id,
      name: data.name,
      email: data.email,
      phone: data.phone,
      avatar: data.avatar,
    );

    return entity;
  }

  @override
  Future<ProfileEntity> updateProfile({
    String? name,
    String? email,
    String? phone,
    String? avatarPath,
  }) async {
    final formFields = <String, dynamic>{
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
    };

    if (avatarPath != null) {
      formFields['avatar'] = await MultipartFile.fromFile(
        avatarPath,
        filename: avatarPath.split('/').last,
      );
    }

    final formData = FormData.fromMap(formFields);

    Log.debug('Sending updateProfile formData fields: ${formFields.keys}');

    final resp = await BaseNetworking.shared.post(
      partUrl: 'profile',
      data: formData,
      contentType: 'multipart/form-data',
    );

    final data = resp.data['data'];
    final entity = ProfileEntity(
      id: data['id'],
      name: data['name'],
      email: data['email'],
      phone: data['phone'],
      avatar: data['avatar'],
    );

    await ProfileStorageHelper.saveProfile(entity);
    return entity;
  }
}
