import 'package:freezed_annotation/freezed_annotation.dart';

class ProfileEntity {
  final int id;
  final String name;
  final String email;
  final String? phone;
  final String? avatar;

  const ProfileEntity({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.avatar,
  });

  ProfileEntity copyWith({
    int? id,
    String? name,
    String? email,
    String? phone,
    String? avatar,
  }) {
    return ProfileEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      avatar: avatar ?? this.avatar,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          email == other.email &&
          phone == other.phone &&
          avatar == other.avatar;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      email.hashCode ^
      phone.hashCode ^
      avatar.hashCode;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'avatar': avatar,
    };
  }

  factory ProfileEntity.fromJson(Map<String, dynamic> json) {
    return ProfileEntity(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      avatar: json['avatar'],
    );
  }
}
