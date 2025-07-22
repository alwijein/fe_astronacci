import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fe_astronacci/feature/home/domain/entities/user_entity.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
abstract class UserModel with _$UserModel {
  const factory UserModel({
    required int id,
    required String email,
    required String name,
    required String? avatar,
    required String? phone,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
