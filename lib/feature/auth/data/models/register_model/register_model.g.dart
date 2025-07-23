// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RegisterRequestModel _$RegisterRequestModelFromJson(
        Map<String, dynamic> json) =>
    _RegisterRequestModel(
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      phone: json['phone'] as String?,
    );

Map<String, dynamic> _$RegisterRequestModelToJson(
        _RegisterRequestModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'phone': instance.phone,
    };

_RegisterResponseModel _$RegisterResponseModelFromJson(
        Map<String, dynamic> json) =>
    _RegisterResponseModel(
      tokenType: json['token_type'] as String,
      accessToken: json['access_token'] as String,
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RegisterResponseModelToJson(
        _RegisterResponseModel instance) =>
    <String, dynamic>{
      'token_type': instance.tokenType,
      'access_token': instance.accessToken,
      'user': instance.user,
    };
