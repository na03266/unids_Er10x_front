// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'statistic_request_param.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StatisticRequestParam {
  int get deviceSettingId;
  IntervalType get intervalType;
  String get startDate;
  String get endDate;

  /// Create a copy of StatisticRequestParam
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $StatisticRequestParamCopyWith<StatisticRequestParam> get copyWith =>
      _$StatisticRequestParamCopyWithImpl<StatisticRequestParam>(
          this as StatisticRequestParam, _$identity);

  /// Serializes this StatisticRequestParam to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is StatisticRequestParam &&
            (identical(other.deviceSettingId, deviceSettingId) ||
                other.deviceSettingId == deviceSettingId) &&
            (identical(other.intervalType, intervalType) ||
                other.intervalType == intervalType) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, deviceSettingId, intervalType, startDate, endDate);

  @override
  String toString() {
    return 'StatisticRequestParam(deviceSettingId: $deviceSettingId, intervalType: $intervalType, startDate: $startDate, endDate: $endDate)';
  }
}

/// @nodoc
abstract mixin class $StatisticRequestParamCopyWith<$Res> {
  factory $StatisticRequestParamCopyWith(StatisticRequestParam value,
          $Res Function(StatisticRequestParam) _then) =
      _$StatisticRequestParamCopyWithImpl;
  @useResult
  $Res call(
      {int deviceSettingId,
      IntervalType intervalType,
      String startDate,
      String endDate});
}

/// @nodoc
class _$StatisticRequestParamCopyWithImpl<$Res>
    implements $StatisticRequestParamCopyWith<$Res> {
  _$StatisticRequestParamCopyWithImpl(this._self, this._then);

  final StatisticRequestParam _self;
  final $Res Function(StatisticRequestParam) _then;

  /// Create a copy of StatisticRequestParam
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? deviceSettingId = null,
    Object? intervalType = null,
    Object? startDate = null,
    Object? endDate = null,
  }) {
    return _then(_self.copyWith(
      deviceSettingId: null == deviceSettingId
          ? _self.deviceSettingId
          : deviceSettingId // ignore: cast_nullable_to_non_nullable
              as int,
      intervalType: null == intervalType
          ? _self.intervalType
          : intervalType // ignore: cast_nullable_to_non_nullable
              as IntervalType,
      startDate: null == startDate
          ? _self.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as String,
      endDate: null == endDate
          ? _self.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [StatisticRequestParam].
extension StatisticRequestParamPatterns on StatisticRequestParam {
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
    TResult Function(_StatisticRequestParam value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _StatisticRequestParam() when $default != null:
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
    TResult Function(_StatisticRequestParam value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StatisticRequestParam():
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
    TResult? Function(_StatisticRequestParam value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StatisticRequestParam() when $default != null:
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
    TResult Function(int deviceSettingId, IntervalType intervalType,
            String startDate, String endDate)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _StatisticRequestParam() when $default != null:
        return $default(_that.deviceSettingId, _that.intervalType,
            _that.startDate, _that.endDate);
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
    TResult Function(int deviceSettingId, IntervalType intervalType,
            String startDate, String endDate)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StatisticRequestParam():
        return $default(_that.deviceSettingId, _that.intervalType,
            _that.startDate, _that.endDate);
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
    TResult? Function(int deviceSettingId, IntervalType intervalType,
            String startDate, String endDate)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StatisticRequestParam() when $default != null:
        return $default(_that.deviceSettingId, _that.intervalType,
            _that.startDate, _that.endDate);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _StatisticRequestParam implements StatisticRequestParam {
  const _StatisticRequestParam(
      {required this.deviceSettingId,
      required this.intervalType,
      required this.startDate,
      required this.endDate});
  factory _StatisticRequestParam.fromJson(Map<String, dynamic> json) =>
      _$StatisticRequestParamFromJson(json);

  @override
  final int deviceSettingId;
  @override
  final IntervalType intervalType;
  @override
  final String startDate;
  @override
  final String endDate;

  /// Create a copy of StatisticRequestParam
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$StatisticRequestParamCopyWith<_StatisticRequestParam> get copyWith =>
      __$StatisticRequestParamCopyWithImpl<_StatisticRequestParam>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$StatisticRequestParamToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _StatisticRequestParam &&
            (identical(other.deviceSettingId, deviceSettingId) ||
                other.deviceSettingId == deviceSettingId) &&
            (identical(other.intervalType, intervalType) ||
                other.intervalType == intervalType) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, deviceSettingId, intervalType, startDate, endDate);

  @override
  String toString() {
    return 'StatisticRequestParam(deviceSettingId: $deviceSettingId, intervalType: $intervalType, startDate: $startDate, endDate: $endDate)';
  }
}

/// @nodoc
abstract mixin class _$StatisticRequestParamCopyWith<$Res>
    implements $StatisticRequestParamCopyWith<$Res> {
  factory _$StatisticRequestParamCopyWith(_StatisticRequestParam value,
          $Res Function(_StatisticRequestParam) _then) =
      __$StatisticRequestParamCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int deviceSettingId,
      IntervalType intervalType,
      String startDate,
      String endDate});
}

/// @nodoc
class __$StatisticRequestParamCopyWithImpl<$Res>
    implements _$StatisticRequestParamCopyWith<$Res> {
  __$StatisticRequestParamCopyWithImpl(this._self, this._then);

  final _StatisticRequestParam _self;
  final $Res Function(_StatisticRequestParam) _then;

  /// Create a copy of StatisticRequestParam
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? deviceSettingId = null,
    Object? intervalType = null,
    Object? startDate = null,
    Object? endDate = null,
  }) {
    return _then(_StatisticRequestParam(
      deviceSettingId: null == deviceSettingId
          ? _self.deviceSettingId
          : deviceSettingId // ignore: cast_nullable_to_non_nullable
              as int,
      intervalType: null == intervalType
          ? _self.intervalType
          : intervalType // ignore: cast_nullable_to_non_nullable
              as IntervalType,
      startDate: null == startDate
          ? _self.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as String,
      endDate: null == endDate
          ? _self.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
