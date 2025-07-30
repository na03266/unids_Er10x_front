// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'statistic_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
StatisticResponseBase _$StatisticResponseBaseFromJson(
    Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'loading':
      return StatisticResponseLoading.fromJson(json);
    case 'error':
      return StatisticResponseError.fromJson(json);
    case 'data':
      return StatisticDataList.fromJson(json);

    default:
      throw CheckedFromJsonException(
          json,
          'runtimeType',
          'StatisticResponseBase',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$StatisticResponseBase {
  /// Serializes this StatisticResponseBase to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is StatisticResponseBase);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'StatisticResponseBase()';
  }
}

/// @nodoc
class $StatisticResponseBaseCopyWith<$Res> {
  $StatisticResponseBaseCopyWith(
      StatisticResponseBase _, $Res Function(StatisticResponseBase) __);
}

/// Adds pattern-matching-related methods to [StatisticResponseBase].
extension StatisticResponseBasePatterns on StatisticResponseBase {
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
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StatisticResponseLoading value)? loading,
    TResult Function(StatisticResponseError value)? error,
    TResult Function(StatisticDataList value)? data,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case StatisticResponseLoading() when loading != null:
        return loading(_that);
      case StatisticResponseError() when error != null:
        return error(_that);
      case StatisticDataList() when data != null:
        return data(_that);
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
  TResult map<TResult extends Object?>({
    required TResult Function(StatisticResponseLoading value) loading,
    required TResult Function(StatisticResponseError value) error,
    required TResult Function(StatisticDataList value) data,
  }) {
    final _that = this;
    switch (_that) {
      case StatisticResponseLoading():
        return loading(_that);
      case StatisticResponseError():
        return error(_that);
      case StatisticDataList():
        return data(_that);
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
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(StatisticResponseLoading value)? loading,
    TResult? Function(StatisticResponseError value)? error,
    TResult? Function(StatisticDataList value)? data,
  }) {
    final _that = this;
    switch (_that) {
      case StatisticResponseLoading() when loading != null:
        return loading(_that);
      case StatisticResponseError() when error != null:
        return error(_that);
      case StatisticDataList() when data != null:
        return data(_that);
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
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String message)? error,
    TResult Function(List<StatisticData> data, String startDate, String endDate,
            IntervalType intervalType, SensorInfoModel sensorInfo)?
        data,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case StatisticResponseLoading() when loading != null:
        return loading();
      case StatisticResponseError() when error != null:
        return error(_that.message);
      case StatisticDataList() when data != null:
        return data(_that.data, _that.startDate, _that.endDate,
            _that.intervalType, _that.sensorInfo);
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
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(String message) error,
    required TResult Function(
            List<StatisticData> data,
            String startDate,
            String endDate,
            IntervalType intervalType,
            SensorInfoModel sensorInfo)
        data,
  }) {
    final _that = this;
    switch (_that) {
      case StatisticResponseLoading():
        return loading();
      case StatisticResponseError():
        return error(_that.message);
      case StatisticDataList():
        return data(_that.data, _that.startDate, _that.endDate,
            _that.intervalType, _that.sensorInfo);
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
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(String message)? error,
    TResult? Function(
            List<StatisticData> data,
            String startDate,
            String endDate,
            IntervalType intervalType,
            SensorInfoModel sensorInfo)?
        data,
  }) {
    final _that = this;
    switch (_that) {
      case StatisticResponseLoading() when loading != null:
        return loading();
      case StatisticResponseError() when error != null:
        return error(_that.message);
      case StatisticDataList() when data != null:
        return data(_that.data, _that.startDate, _that.endDate,
            _that.intervalType, _that.sensorInfo);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class StatisticResponseLoading implements StatisticResponseBase {
  const StatisticResponseLoading({final String? $type})
      : $type = $type ?? 'loading';
  factory StatisticResponseLoading.fromJson(Map<String, dynamic> json) =>
      _$StatisticResponseLoadingFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  Map<String, dynamic> toJson() {
    return _$StatisticResponseLoadingToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is StatisticResponseLoading);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'StatisticResponseBase.loading()';
  }
}

/// @nodoc
@JsonSerializable()
class StatisticResponseError implements StatisticResponseBase {
  const StatisticResponseError({required this.message, final String? $type})
      : $type = $type ?? 'error';
  factory StatisticResponseError.fromJson(Map<String, dynamic> json) =>
      _$StatisticResponseErrorFromJson(json);

  final String message;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of StatisticResponseBase
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $StatisticResponseErrorCopyWith<StatisticResponseError> get copyWith =>
      _$StatisticResponseErrorCopyWithImpl<StatisticResponseError>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$StatisticResponseErrorToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is StatisticResponseError &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'StatisticResponseBase.error(message: $message)';
  }
}

/// @nodoc
abstract mixin class $StatisticResponseErrorCopyWith<$Res>
    implements $StatisticResponseBaseCopyWith<$Res> {
  factory $StatisticResponseErrorCopyWith(StatisticResponseError value,
          $Res Function(StatisticResponseError) _then) =
      _$StatisticResponseErrorCopyWithImpl;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$StatisticResponseErrorCopyWithImpl<$Res>
    implements $StatisticResponseErrorCopyWith<$Res> {
  _$StatisticResponseErrorCopyWithImpl(this._self, this._then);

  final StatisticResponseError _self;
  final $Res Function(StatisticResponseError) _then;

  /// Create a copy of StatisticResponseBase
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
  }) {
    return _then(StatisticResponseError(
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class StatisticDataList implements StatisticResponseBase {
  const StatisticDataList(
      {required final List<StatisticData> data,
      required this.startDate,
      required this.endDate,
      required this.intervalType,
      required this.sensorInfo,
      final String? $type})
      : _data = data,
        $type = $type ?? 'data';
  factory StatisticDataList.fromJson(Map<String, dynamic> json) =>
      _$StatisticDataListFromJson(json);

  final List<StatisticData> _data;
  List<StatisticData> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  final String startDate;
  final String endDate;
  final IntervalType intervalType;
  final SensorInfoModel sensorInfo;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of StatisticResponseBase
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $StatisticDataListCopyWith<StatisticDataList> get copyWith =>
      _$StatisticDataListCopyWithImpl<StatisticDataList>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$StatisticDataListToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is StatisticDataList &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.intervalType, intervalType) ||
                other.intervalType == intervalType) &&
            (identical(other.sensorInfo, sensorInfo) ||
                other.sensorInfo == sensorInfo));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_data),
      startDate,
      endDate,
      intervalType,
      sensorInfo);

  @override
  String toString() {
    return 'StatisticResponseBase.data(data: $data, startDate: $startDate, endDate: $endDate, intervalType: $intervalType, sensorInfo: $sensorInfo)';
  }
}

/// @nodoc
abstract mixin class $StatisticDataListCopyWith<$Res>
    implements $StatisticResponseBaseCopyWith<$Res> {
  factory $StatisticDataListCopyWith(
          StatisticDataList value, $Res Function(StatisticDataList) _then) =
      _$StatisticDataListCopyWithImpl;
  @useResult
  $Res call(
      {List<StatisticData> data,
      String startDate,
      String endDate,
      IntervalType intervalType,
      SensorInfoModel sensorInfo});

  $SensorInfoModelCopyWith<$Res> get sensorInfo;
}

/// @nodoc
class _$StatisticDataListCopyWithImpl<$Res>
    implements $StatisticDataListCopyWith<$Res> {
  _$StatisticDataListCopyWithImpl(this._self, this._then);

  final StatisticDataList _self;
  final $Res Function(StatisticDataList) _then;

  /// Create a copy of StatisticResponseBase
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? data = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? intervalType = null,
    Object? sensorInfo = null,
  }) {
    return _then(StatisticDataList(
      data: null == data
          ? _self._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<StatisticData>,
      startDate: null == startDate
          ? _self.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as String,
      endDate: null == endDate
          ? _self.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as String,
      intervalType: null == intervalType
          ? _self.intervalType
          : intervalType // ignore: cast_nullable_to_non_nullable
              as IntervalType,
      sensorInfo: null == sensorInfo
          ? _self.sensorInfo
          : sensorInfo // ignore: cast_nullable_to_non_nullable
              as SensorInfoModel,
    ));
  }

  /// Create a copy of StatisticResponseBase
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SensorInfoModelCopyWith<$Res> get sensorInfo {
    return $SensorInfoModelCopyWith<$Res>(_self.sensorInfo, (value) {
      return _then(_self.copyWith(sensorInfo: value));
    });
  }
}

/// @nodoc
mixin _$StatisticData {
  String get timeBucket;
  set timeBucket(String value);
  double get minValue;
  set minValue(double value);
  double get maxValue;
  set maxValue(double value);
  double get avgValue;
  set avgValue(double value);

  /// Create a copy of StatisticData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $StatisticDataCopyWith<StatisticData> get copyWith =>
      _$StatisticDataCopyWithImpl<StatisticData>(
          this as StatisticData, _$identity);

  /// Serializes this StatisticData to a JSON map.
  Map<String, dynamic> toJson();

  @override
  String toString() {
    return 'StatisticData(timeBucket: $timeBucket, minValue: $minValue, maxValue: $maxValue, avgValue: $avgValue)';
  }
}

/// @nodoc
abstract mixin class $StatisticDataCopyWith<$Res> {
  factory $StatisticDataCopyWith(
          StatisticData value, $Res Function(StatisticData) _then) =
      _$StatisticDataCopyWithImpl;
  @useResult
  $Res call(
      {String timeBucket, double minValue, double maxValue, double avgValue});
}

/// @nodoc
class _$StatisticDataCopyWithImpl<$Res>
    implements $StatisticDataCopyWith<$Res> {
  _$StatisticDataCopyWithImpl(this._self, this._then);

  final StatisticData _self;
  final $Res Function(StatisticData) _then;

  /// Create a copy of StatisticData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timeBucket = null,
    Object? minValue = null,
    Object? maxValue = null,
    Object? avgValue = null,
  }) {
    return _then(_self.copyWith(
      timeBucket: null == timeBucket
          ? _self.timeBucket
          : timeBucket // ignore: cast_nullable_to_non_nullable
              as String,
      minValue: null == minValue
          ? _self.minValue
          : minValue // ignore: cast_nullable_to_non_nullable
              as double,
      maxValue: null == maxValue
          ? _self.maxValue
          : maxValue // ignore: cast_nullable_to_non_nullable
              as double,
      avgValue: null == avgValue
          ? _self.avgValue
          : avgValue // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// Adds pattern-matching-related methods to [StatisticData].
extension StatisticDataPatterns on StatisticData {
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
    TResult Function(_StatisticData value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _StatisticData() when $default != null:
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
    TResult Function(_StatisticData value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StatisticData():
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
    TResult? Function(_StatisticData value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StatisticData() when $default != null:
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
    TResult Function(String timeBucket, double minValue, double maxValue,
            double avgValue)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _StatisticData() when $default != null:
        return $default(
            _that.timeBucket, _that.minValue, _that.maxValue, _that.avgValue);
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
    TResult Function(String timeBucket, double minValue, double maxValue,
            double avgValue)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StatisticData():
        return $default(
            _that.timeBucket, _that.minValue, _that.maxValue, _that.avgValue);
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
    TResult? Function(String timeBucket, double minValue, double maxValue,
            double avgValue)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StatisticData() when $default != null:
        return $default(
            _that.timeBucket, _that.minValue, _that.maxValue, _that.avgValue);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _StatisticData implements StatisticData {
  _StatisticData(
      {required this.timeBucket,
      required this.minValue,
      required this.maxValue,
      required this.avgValue});
  factory _StatisticData.fromJson(Map<String, dynamic> json) =>
      _$StatisticDataFromJson(json);

  @override
  String timeBucket;
  @override
  double minValue;
  @override
  double maxValue;
  @override
  double avgValue;

  /// Create a copy of StatisticData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$StatisticDataCopyWith<_StatisticData> get copyWith =>
      __$StatisticDataCopyWithImpl<_StatisticData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$StatisticDataToJson(
      this,
    );
  }

  @override
  String toString() {
    return 'StatisticData(timeBucket: $timeBucket, minValue: $minValue, maxValue: $maxValue, avgValue: $avgValue)';
  }
}

/// @nodoc
abstract mixin class _$StatisticDataCopyWith<$Res>
    implements $StatisticDataCopyWith<$Res> {
  factory _$StatisticDataCopyWith(
          _StatisticData value, $Res Function(_StatisticData) _then) =
      __$StatisticDataCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String timeBucket, double minValue, double maxValue, double avgValue});
}

/// @nodoc
class __$StatisticDataCopyWithImpl<$Res>
    implements _$StatisticDataCopyWith<$Res> {
  __$StatisticDataCopyWithImpl(this._self, this._then);

  final _StatisticData _self;
  final $Res Function(_StatisticData) _then;

  /// Create a copy of StatisticData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? timeBucket = null,
    Object? minValue = null,
    Object? maxValue = null,
    Object? avgValue = null,
  }) {
    return _then(_StatisticData(
      timeBucket: null == timeBucket
          ? _self.timeBucket
          : timeBucket // ignore: cast_nullable_to_non_nullable
              as String,
      minValue: null == minValue
          ? _self.minValue
          : minValue // ignore: cast_nullable_to_non_nullable
              as double,
      maxValue: null == maxValue
          ? _self.maxValue
          : maxValue // ignore: cast_nullable_to_non_nullable
              as double,
      avgValue: null == avgValue
          ? _self.avgValue
          : avgValue // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

// dart format on
