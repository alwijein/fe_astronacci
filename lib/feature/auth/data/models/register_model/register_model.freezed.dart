// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'register_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RegisterRequestModel {
  String get name;
  String get email;
  String get password;
  String? get phone;

  /// Create a copy of RegisterRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RegisterRequestModelCopyWith<RegisterRequestModel> get copyWith =>
      _$RegisterRequestModelCopyWithImpl<RegisterRequestModel>(
          this as RegisterRequestModel, _$identity);

  /// Serializes this RegisterRequestModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RegisterRequestModel &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.phone, phone) || other.phone == phone));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, email, password, phone);

  @override
  String toString() {
    return 'RegisterRequestModel(name: $name, email: $email, password: $password, phone: $phone)';
  }
}

/// @nodoc
abstract mixin class $RegisterRequestModelCopyWith<$Res> {
  factory $RegisterRequestModelCopyWith(RegisterRequestModel value,
          $Res Function(RegisterRequestModel) _then) =
      _$RegisterRequestModelCopyWithImpl;
  @useResult
  $Res call({String name, String email, String password, String? phone});
}

/// @nodoc
class _$RegisterRequestModelCopyWithImpl<$Res>
    implements $RegisterRequestModelCopyWith<$Res> {
  _$RegisterRequestModelCopyWithImpl(this._self, this._then);

  final RegisterRequestModel _self;
  final $Res Function(RegisterRequestModel) _then;

  /// Create a copy of RegisterRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? email = null,
    Object? password = null,
    Object? phone = freezed,
  }) {
    return _then(_self.copyWith(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _self.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      phone: freezed == phone
          ? _self.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [RegisterRequestModel].
extension RegisterRequestModelPatterns on RegisterRequestModel {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_RegisterRequestModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RegisterRequestModel() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_RegisterRequestModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RegisterRequestModel():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_RegisterRequestModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RegisterRequestModel() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String name, String email, String password, String? phone)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RegisterRequestModel() when $default != null:
        return $default(_that.name, _that.email, _that.password, _that.phone);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String name, String email, String password, String? phone)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RegisterRequestModel():
        return $default(_that.name, _that.email, _that.password, _that.phone);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String name, String email, String password, String? phone)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RegisterRequestModel() when $default != null:
        return $default(_that.name, _that.email, _that.password, _that.phone);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _RegisterRequestModel implements RegisterRequestModel {
  const _RegisterRequestModel(
      {required this.name,
      required this.email,
      required this.password,
      this.phone});
  factory _RegisterRequestModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestModelFromJson(json);

  @override
  final String name;
  @override
  final String email;
  @override
  final String password;
  @override
  final String? phone;

  /// Create a copy of RegisterRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RegisterRequestModelCopyWith<_RegisterRequestModel> get copyWith =>
      __$RegisterRequestModelCopyWithImpl<_RegisterRequestModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$RegisterRequestModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RegisterRequestModel &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.phone, phone) || other.phone == phone));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, email, password, phone);

  @override
  String toString() {
    return 'RegisterRequestModel(name: $name, email: $email, password: $password, phone: $phone)';
  }
}

/// @nodoc
abstract mixin class _$RegisterRequestModelCopyWith<$Res>
    implements $RegisterRequestModelCopyWith<$Res> {
  factory _$RegisterRequestModelCopyWith(_RegisterRequestModel value,
          $Res Function(_RegisterRequestModel) _then) =
      __$RegisterRequestModelCopyWithImpl;
  @override
  @useResult
  $Res call({String name, String email, String password, String? phone});
}

/// @nodoc
class __$RegisterRequestModelCopyWithImpl<$Res>
    implements _$RegisterRequestModelCopyWith<$Res> {
  __$RegisterRequestModelCopyWithImpl(this._self, this._then);

  final _RegisterRequestModel _self;
  final $Res Function(_RegisterRequestModel) _then;

  /// Create a copy of RegisterRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = null,
    Object? email = null,
    Object? password = null,
    Object? phone = freezed,
  }) {
    return _then(_RegisterRequestModel(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _self.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      phone: freezed == phone
          ? _self.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$RegisterResponseModel {
  @JsonKey(name: 'token_type')
  String get tokenType;
  @JsonKey(name: 'access_token')
  String get accessToken;
  UserModel get user;

  /// Create a copy of RegisterResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RegisterResponseModelCopyWith<RegisterResponseModel> get copyWith =>
      _$RegisterResponseModelCopyWithImpl<RegisterResponseModel>(
          this as RegisterResponseModel, _$identity);

  /// Serializes this RegisterResponseModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RegisterResponseModel &&
            (identical(other.tokenType, tokenType) ||
                other.tokenType == tokenType) &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.user, user) || other.user == user));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, tokenType, accessToken, user);

  @override
  String toString() {
    return 'RegisterResponseModel(tokenType: $tokenType, accessToken: $accessToken, user: $user)';
  }
}

/// @nodoc
abstract mixin class $RegisterResponseModelCopyWith<$Res> {
  factory $RegisterResponseModelCopyWith(RegisterResponseModel value,
          $Res Function(RegisterResponseModel) _then) =
      _$RegisterResponseModelCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'token_type') String tokenType,
      @JsonKey(name: 'access_token') String accessToken,
      UserModel user});

  $UserModelCopyWith<$Res> get user;
}

/// @nodoc
class _$RegisterResponseModelCopyWithImpl<$Res>
    implements $RegisterResponseModelCopyWith<$Res> {
  _$RegisterResponseModelCopyWithImpl(this._self, this._then);

  final RegisterResponseModel _self;
  final $Res Function(RegisterResponseModel) _then;

  /// Create a copy of RegisterResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tokenType = null,
    Object? accessToken = null,
    Object? user = null,
  }) {
    return _then(_self.copyWith(
      tokenType: null == tokenType
          ? _self.tokenType
          : tokenType // ignore: cast_nullable_to_non_nullable
              as String,
      accessToken: null == accessToken
          ? _self.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
      user: null == user
          ? _self.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel,
    ));
  }

  /// Create a copy of RegisterResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res> get user {
    return $UserModelCopyWith<$Res>(_self.user, (value) {
      return _then(_self.copyWith(user: value));
    });
  }
}

/// Adds pattern-matching-related methods to [RegisterResponseModel].
extension RegisterResponseModelPatterns on RegisterResponseModel {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_RegisterResponseModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RegisterResponseModel() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_RegisterResponseModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RegisterResponseModel():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_RegisterResponseModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RegisterResponseModel() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(@JsonKey(name: 'token_type') String tokenType,
            @JsonKey(name: 'access_token') String accessToken, UserModel user)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RegisterResponseModel() when $default != null:
        return $default(_that.tokenType, _that.accessToken, _that.user);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(@JsonKey(name: 'token_type') String tokenType,
            @JsonKey(name: 'access_token') String accessToken, UserModel user)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RegisterResponseModel():
        return $default(_that.tokenType, _that.accessToken, _that.user);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(@JsonKey(name: 'token_type') String tokenType,
            @JsonKey(name: 'access_token') String accessToken, UserModel user)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RegisterResponseModel() when $default != null:
        return $default(_that.tokenType, _that.accessToken, _that.user);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _RegisterResponseModel implements RegisterResponseModel {
  const _RegisterResponseModel(
      {@JsonKey(name: 'token_type') required this.tokenType,
      @JsonKey(name: 'access_token') required this.accessToken,
      required this.user});
  factory _RegisterResponseModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseModelFromJson(json);

  @override
  @JsonKey(name: 'token_type')
  final String tokenType;
  @override
  @JsonKey(name: 'access_token')
  final String accessToken;
  @override
  final UserModel user;

  /// Create a copy of RegisterResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RegisterResponseModelCopyWith<_RegisterResponseModel> get copyWith =>
      __$RegisterResponseModelCopyWithImpl<_RegisterResponseModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$RegisterResponseModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RegisterResponseModel &&
            (identical(other.tokenType, tokenType) ||
                other.tokenType == tokenType) &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.user, user) || other.user == user));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, tokenType, accessToken, user);

  @override
  String toString() {
    return 'RegisterResponseModel(tokenType: $tokenType, accessToken: $accessToken, user: $user)';
  }
}

/// @nodoc
abstract mixin class _$RegisterResponseModelCopyWith<$Res>
    implements $RegisterResponseModelCopyWith<$Res> {
  factory _$RegisterResponseModelCopyWith(_RegisterResponseModel value,
          $Res Function(_RegisterResponseModel) _then) =
      __$RegisterResponseModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'token_type') String tokenType,
      @JsonKey(name: 'access_token') String accessToken,
      UserModel user});

  @override
  $UserModelCopyWith<$Res> get user;
}

/// @nodoc
class __$RegisterResponseModelCopyWithImpl<$Res>
    implements _$RegisterResponseModelCopyWith<$Res> {
  __$RegisterResponseModelCopyWithImpl(this._self, this._then);

  final _RegisterResponseModel _self;
  final $Res Function(_RegisterResponseModel) _then;

  /// Create a copy of RegisterResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? tokenType = null,
    Object? accessToken = null,
    Object? user = null,
  }) {
    return _then(_RegisterResponseModel(
      tokenType: null == tokenType
          ? _self.tokenType
          : tokenType // ignore: cast_nullable_to_non_nullable
              as String,
      accessToken: null == accessToken
          ? _self.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
      user: null == user
          ? _self.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel,
    ));
  }

  /// Create a copy of RegisterResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res> get user {
    return $UserModelCopyWith<$Res>(_self.user, (value) {
      return _then(_self.copyWith(user: value));
    });
  }
}

// dart format on
