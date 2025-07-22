class UserEntity {
  final int id;
  final String email;
  final String name;
  final String? phone;
  final String? avatar;

  UserEntity({
    required this.id,
    required this.email,
    required this.name,
    required this.phone,
    required this.avatar,
  });

  UserEntity copyWith({
    int? id,
    String? email,
    String? name,
    String? phone,
    String? avatar,
  }) {
    return UserEntity(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      avatar: avatar ?? this.avatar,
    );
  }
}
