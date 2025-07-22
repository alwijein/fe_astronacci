import 'dart:convert';
import 'package:fe_astronacci/common/utils/local_storage/common_shared_preferences.dart';
import 'package:fe_astronacci/feature/profile/domain/entities/profile_entity.dart';

class ProfileStorageHelper {
  static Future<void> saveProfile(ProfileEntity entity) async {
    final jsonStr = jsonEncode(entity.toJson());
    CommonSharedPreferences.shared.save<String>(
      CommonSharedKey.userProfile,
      jsonStr,
    );
  }

  static Future<ProfileEntity?> getProfile() async {
    final jsonStr = await CommonSharedPreferences.shared.load<String>(
      CommonSharedKey.userProfile,
      defaultValue: '',
    );
    if (jsonStr.isEmpty) return null;

    return ProfileEntity.fromJson(jsonDecode(jsonStr));
  }

  static Future<void> clearProfile() async {
    await CommonSharedPreferences.shared
        .removeData(CommonSharedKey.userProfile);
  }
}
