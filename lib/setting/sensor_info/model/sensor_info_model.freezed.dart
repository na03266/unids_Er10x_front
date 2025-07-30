// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sensor_info_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SensorInfoModel {
  @JsonKey(includeToJson: false)
  int? get id;
  @JsonKey(includeToJson: false)
  set id(int? value);
  String? get sensorId;
  set sensorId(String? value);
  String? get name;
  set name(String? value);
  String? get krName;
  set krName(String? value);
  String? get deviceId;
  set deviceId(String? value);
  double? get maximum;
  set maximum(double? value);
  double? get minimum;
  set minimum(double? value);
  String? get unit;
  set unit(String? value);
  double? get value;
  set value(double? value);

  /// Create a copy of SensorInfoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SensorInfoModelCopyWith<SensorInfoModel> get copyWith =>
      _$SensorInfoModelCopyWithImpl<SensorInfoModel>(
          this as SensorInfoModel, _$identity);

  /// Serializes this SensorInfoModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  String toString() {
    return 'SensorInfoModel(id: $id, sensorId: $sensorId, name: $name, krName: $krName, deviceId: $deviceId, maximum: $maximum, minimum: $minimum, unit: $unit, value: $value)';
  }
}

/// @nodoc
abstract mixin class $SensorInfoModelCopyWith<$Res> {
  factory $SensorInfoModelCopyWith(
          SensorInfoModel value, $Res Function(SensorInfoModel) _then) =
      _$SensorInfoModelCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(includeToJson: false) int? id,
      String? sensorId,
      String? name,
      String? krName,
      String? deviceId,
      double? maximum,
      double? minimum,
      String? unit,
      double? value});
}

/// @nodoc
class _$SensorInfoModelCopyWithImpl<$Res>
    implements $SensorInfoModelCopyWith<$Res> {
  _$SensorInfoModelCopyWithImpl(this._self, this._then);

  final SensorInfoModel _self;
  final $Res Function(SensorInfoModel) _then;

  /// Create a copy of SensorInfoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? sensorId = freezed,
    Object? name = freezed,
    Object? krName = freezed,
    Object? deviceId = freezed,
    Object? maximum = freezed,
    Object? minimum = freezed,
    Object? unit = freezed,
    Object? value = freezed,
  }) {
    return _then(_self.copyWith(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      sensorId: freezed == sensorId
          ? _self.sensorId
          : sensorId // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      krName: freezed == krName
          ? _self.krName
          : krName // ignore: cast_nullable_to_non_nullable
              as String?,
      deviceId: freezed == deviceId
          ? _self.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String?,
      maximum: freezed == maximum
          ? _self.maximum
          : maximum // ignore: cast_nullable_to_non_nullable
              as double?,
      minimum: freezed == minimum
          ? _self.minimum
          : minimum // ignore: cast_nullable_to_non_nullable
              as double?,
      unit: freezed == unit
          ? _self.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String?,
      value: freezed == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// Adds pattern-matching-related methods to [SensorInfoModel].
extension SensorInfoModelPatterns on SensorInfoModel {
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
    TResult Function(_SensorInfoModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SensorInfoModel() when $default != null:
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
    TResult Function(_SensorInfoModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SensorInfoModel():
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
    TResult? Function(_SensorInfoModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SensorInfoModel() when $default != null:
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
    TResult Function(
            @JsonKey(includeToJson: false) int? id,
            String? sensorId,
            String? name,
            String? krName,
            String? deviceId,
            double? maximum,
            double? minimum,
            String? unit,
            double? value)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SensorInfoModel() when $default != null:
        return $default(
            _that.id,
            _that.sensorId,
            _that.name,
            _that.krName,
            _that.deviceId,
            _that.maximum,
            _that.minimum,
            _that.unit,
            _that.value);
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
    TResult Function(
            @JsonKey(includeToJson: false) int? id,
            String? sensorId,
            String? name,
            String? krName,
            String? deviceId,
            double? maximum,
            double? minimum,
            String? unit,
            double? value)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SensorInfoModel():
        return $default(
            _that.id,
            _that.sensorId,
            _that.name,
            _that.krName,
            _that.deviceId,
            _that.maximum,
            _that.minimum,
            _that.unit,
            _that.value);
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
            @JsonKey(includeToJson: false) int? id,
            String? sensorId,
            String? name,
            String? krName,
            String? deviceId,
            double? maximum,
            double? minimum,
            String? unit,
            double? value)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SensorInfoModel() when $default != null:
        return $default(
            _that.id,
            _that.sensorId,
            _that.name,
            _that.krName,
            _that.deviceId,
            _that.maximum,
            _that.minimum,
            _that.unit,
            _that.value);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _SensorInfoModel implements SensorInfoModel {
  _SensorInfoModel(
      {@JsonKey(includeToJson: false) this.id,
      this.sensorId,
      this.name,
      this.krName,
      this.deviceId,
      this.maximum,
      this.minimum,
      this.unit,
      this.value});
  factory _SensorInfoModel.fromJson(Map<String, dynamic> json) =>
      _$SensorInfoModelFromJson(json);

  @override
  @JsonKey(includeToJson: false)
  int? id;
  @override
  String? sensorId;
  @override
  String? name;
  @override
  String? krName;
  @override
  String? deviceId;
  @override
  double? maximum;
  @override
  double? minimum;
  @override
  String? unit;
  @override
  double? value;

  /// Create a copy of SensorInfoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SensorInfoModelCopyWith<_SensorInfoModel> get copyWith =>
      __$SensorInfoModelCopyWithImpl<_SensorInfoModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SensorInfoModelToJson(
      this,
    );
  }

  @override
  String toString() {
    return 'SensorInfoModel(id: $id, sensorId: $sensorId, name: $name, krName: $krName, deviceId: $deviceId, maximum: $maximum, minimum: $minimum, unit: $unit, value: $value)';
  }
}

/// @nodoc
abstract mixin class _$SensorInfoModelCopyWith<$Res>
    implements $SensorInfoModelCopyWith<$Res> {
  factory _$SensorInfoModelCopyWith(
          _SensorInfoModel value, $Res Function(_SensorInfoModel) _then) =
      __$SensorInfoModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(includeToJson: false) int? id,
      String? sensorId,
      String? name,
      String? krName,
      String? deviceId,
      double? maximum,
      double? minimum,
      String? unit,
      double? value});
}

/// @nodoc
class __$SensorInfoModelCopyWithImpl<$Res>
    implements _$SensorInfoModelCopyWith<$Res> {
  __$SensorInfoModelCopyWithImpl(this._self, this._then);

  final _SensorInfoModel _self;
  final $Res Function(_SensorInfoModel) _then;

  /// Create a copy of SensorInfoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = freezed,
    Object? sensorId = freezed,
    Object? name = freezed,
    Object? krName = freezed,
    Object? deviceId = freezed,
    Object? maximum = freezed,
    Object? minimum = freezed,
    Object? unit = freezed,
    Object? value = freezed,
  }) {
    return _then(_SensorInfoModel(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      sensorId: freezed == sensorId
          ? _self.sensorId
          : sensorId // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      krName: freezed == krName
          ? _self.krName
          : krName // ignore: cast_nullable_to_non_nullable
              as String?,
      deviceId: freezed == deviceId
          ? _self.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String?,
      maximum: freezed == maximum
          ? _self.maximum
          : maximum // ignore: cast_nullable_to_non_nullable
              as double?,
      minimum: freezed == minimum
          ? _self.minimum
          : minimum // ignore: cast_nullable_to_non_nullable
              as double?,
      unit: freezed == unit
          ? _self.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String?,
      value: freezed == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

// dart format on
