// lib/feature/home/data/data_sources/user_remote_ds.dart

import 'package:fe_astronacci/common/utils/logging/common_log.dart';
import 'package:fe_astronacci/common/utils/network/base_networking.dart';
import 'package:fe_astronacci/feature/home/data/models/user_model/user_model.dart';

abstract class IUserRemoteDataSource {
  Future<List<UserModel>> fetchUsers({int page = 1});
}

class UserRemoteDataSource implements IUserRemoteDataSource {
  @override
  Future<List<UserModel>> fetchUsers({int page = 1}) async {
    final resp = await BaseNetworking.shared.get(
      partUrl: 'users',
      queryParams: {
        'page': page,
        'per_page': 9,
      },
    );

    Log.debug('fetchUsers called with page: $page');

    Log.debug('fetchUsers response: ${resp.data['data']['data']}');

    final users = (resp.data['data']['data'] as List)
        .map((e) => UserModel.fromJson(e))
        .toList();
    return users;
  }
}
