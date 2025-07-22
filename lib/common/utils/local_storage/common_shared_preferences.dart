import 'package:shared_preferences/shared_preferences.dart';
import 'package:fe_astronacci/common/utils/logging/common_log.dart';

class CommonSharedPreferences {
  static CommonSharedPreferences shared = CommonSharedPreferences();

  static String headerTokenKey = "user_token";

  void save<T>(String key, T data) async {
    final preferences = await SharedPreferences.getInstance();
    if (data is String) {
      Log.debug("simple storage saving String $data \nfor $key");
      preferences.setString(key, data);
    } else if (data is int) {
      Log.debug("simple storage saving int $data \nfor $key");
      preferences.setInt(key, data);
    } else if (data is bool) {
      Log.debug("simple storage saving bool $data \nfor $key");
      preferences.setBool(key, data);
    } else if (data is List<String>) {
      Log.debug("simple storage saving List<String> $data \nfor $key");
      preferences.setStringList(key, data);
    } else if (data is double) {
      Log.debug("simple storage saving double $data \nfor $key");
      preferences.setDouble(key, data);
    }
  }

  Future<T> load<T>(String key, {T? defaultValue}) async {
    final preferences = await SharedPreferences.getInstance();
    Type type = typeOf<T>();
    if (type == String) {
      String? result = preferences.getString(key);
      Log.debug("simple storage result String $result for $key");
      return (result ?? defaultValue ?? "") as T;
    }
    if (type == int) {
      int? result = preferences.getInt(key);
      Log.debug("simple storage result int $result for $key");
      return (result ?? defaultValue ?? 0) as T;
    }
    if (type == bool) {
      bool? result = preferences.getBool(key);
      Log.debug("simple storage result bool $result for $key");
      return (result ?? defaultValue ?? false) as T;
    }
    if (type == List) {
      List? result = preferences.getStringList(key);
      Log.debug("simple storage result list $result for $key");
      return (result ?? defaultValue ?? <String>[]) as T;
    }
    if (type == double) {
      double? result = preferences.getDouble(key);
      Log.debug("simple storage result double $result for $key");
      return (result ?? defaultValue ?? 0.0) as T;
    }

    Object? result = preferences.get(key);
    Log.debug("simple storage result dynamic $result for $key");
    return (result ?? defaultValue ?? Object()) as T;
  }

  Future<bool> removeData(String key) async {
    final preferences = await SharedPreferences.getInstance();
    return await preferences.remove(key);
  }

  Future<bool> cleanData() async {
    final preferences = await SharedPreferences.getInstance();
    return await preferences.clear();
  }

  Type typeOf<T>() => T;
}

class CommonSharedKey {
  static const String userProfile = 'user_profile';
}
