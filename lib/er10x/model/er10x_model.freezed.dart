// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'er10x_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Er10xModel {
  String get deviceId;
  String? get deviceSerial;
  String? get name;

  /// Create a copy of Er10xModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $Er10xModelCopyWith<Er10xModel> get copyWith =>
      _$Er10xModelCopyWithImpl<Er10xModel>(this as Er10xModel, _$identity);

  /// Serializes this Er10xModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Er10xModel &&
            (identical(other.deviceId, deviceId) ||
                other.deviceId == deviceId) &&
            (identical(other.deviceSerial, deviceSerial) ||
                other.deviceSerial == deviceSerial) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, deviceId, deviceSerial, name);

  @override
  String toString() {
    return 'Er10xModel(deviceId: $deviceId, deviceSerial: $deviceSerial, name: $name)';
  }
}

/// @nodoc
abstract mixin class $Er10xModelCopyWith<$Res> {
  factory $Er10xModelCopyWith(
          Er10xModel value, $Res Function(Er10xModel) _then) =
      _$Er10xModelCopyWithImpl;
  @useResult
  $Res call({String deviceId, String? deviceSerial, String? name});
}

/// @nodoc
class _$Er10xModelCopyWithImpl<$Res> implements $Er10xModelCopyWith<$Res> {
  _$Er10xModelCopyWithImpl(this._self, this._then);

  final Er10xModel _self;
  final $Res Function(Er10xModel) _then;

  /// Create a copy of Er10xModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? deviceId = null,
    Object? deviceSerial = freezed,
    Object? name = freezed,
  }) {
    return _then(_self.copyWith(
      deviceId: null == deviceId
          ? _self.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String,
      deviceSerial: freezed == deviceSerial
          ? _self.deviceSerial
          : deviceSerial // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [Er10xModel].
extension Er10xModelPatterns on Er10xModel {
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
    TResult Function(_Er10xModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Er10xModel() when $default != null:
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
    TResult Function(_Er10xModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Er10xModel():
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
    TResult? Function(_Er10xModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Er10xModel() when $default != null:
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
    TResult Function(String deviceId, String? deviceSerial, String? name)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Er10xModel() when $default != null:
        return $default(_that.deviceId, _that.deviceSerial, _that.name);
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
    TResult Function(String deviceId, String? deviceSerial, String? name)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Er10xModel():
        return $default(_that.deviceId, _that.deviceSerial, _that.name);
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
    TResult? Function(String deviceId, String? deviceSerial, String? name)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Er10xModel() when $default != null:
        return $default(_that.deviceId, _that.deviceSerial, _that.name);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Er10xModel implements Er10xModel {
  const _Er10xModel({required this.deviceId, this.deviceSerial, this.name});
  factory _Er10xModel.fromJson(Map<String, dynamic> json) =>
      _$Er10xModelFromJson(json);

  @override
  final String deviceId;
  @override
  final String? deviceSerial;
  @override
  final String? name;

  /// Create a copy of Er10xModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$Er10xModelCopyWith<_Er10xModel> get copyWith =>
      __$Er10xModelCopyWithImpl<_Er10xModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$Er10xModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Er10xModel &&
            (identical(other.deviceId, deviceId) ||
                other.deviceId == deviceId) &&
            (identical(other.deviceSerial, deviceSerial) ||
                other.deviceSerial == deviceSerial) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, deviceId, deviceSerial, name);

  @override
  String toString() {
    return 'Er10xModel(deviceId: $deviceId, deviceSerial: $deviceSerial, name: $name)';
  }
}

/// @nodoc
abstract mixin class _$Er10xModelCopyWith<$Res>
    implements $Er10xModelCopyWith<$Res> {
  factory _$Er10xModelCopyWith(
          _Er10xModel value, $Res Function(_Er10xModel) _then) =
      __$Er10xModelCopyWithImpl;
  @override
  @useResult
  $Res call({String deviceId, String? deviceSerial, String? name});
}

/// @nodoc
class __$Er10xModelCopyWithImpl<$Res> implements _$Er10xModelCopyWith<$Res> {
  __$Er10xModelCopyWithImpl(this._self, this._then);

  final _Er10xModel _self;
  final $Res Function(_Er10xModel) _then;

  /// Create a copy of Er10xModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? deviceId = null,
    Object? deviceSerial = freezed,
    Object? name = freezed,
  }) {
    return _then(_Er10xModel(
      deviceId: null == deviceId
          ? _self.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String,
      deviceSerial: freezed == deviceSerial
          ? _self.deviceSerial
          : deviceSerial // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
