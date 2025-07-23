// lib/feature/home/data/data_sources/user_remote_ds.dart

import 'package:fe_astronacci/common/utils/logging/common_log.dart';
import 'package:fe_astronacci/common/utils/network/base_networking.dart';
import 'package:fe_astronacci/feature/home/data/models/user_model/user_model.dart';

abstract class IUserRemoteDataSource {
  Future<List<UserModel>> fetchUsers({int page = 1, String? search});
}

class UserRemoteDataSource implements IUserRemoteDataSource {
  @override
  Future<List<UserModel>> fetchUsers({int page = 1, String? search}) async {
    final queryParams = {
      'page': search == null ? page : 1,
      'per_page': 9,
      if (search != null && search.isNotEmpty) 'search': search,
    };

    final resp = await BaseNetworking.shared.get(
      partUrl: 'users',
      queryParams: queryParams,
    );

    Log.debug('fetchUsers called with page: $page, search: $search');
    Log.debug('fetchUsers called with page: ${resp.data['data']['data']}');

    final users = (resp.data['data']['data'] as List)
        .map((e) => UserModel.fromJson(e))
        .toList();
    return users;
  }
}
