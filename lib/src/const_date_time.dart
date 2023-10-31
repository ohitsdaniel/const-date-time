import 'constructor_type.dart';

class ConstDateTime implements DateTime {
  const ConstDateTime(int year,
      [int month = 1,
      int day = 1,
      int hour = 0,
      int minute = 0,
      int second = 0,
      int millisecond = 0,
      int microsecond = 0])
      : this._internal(ConstructorType.components,
            year: year,
            month: month,
            day: day,
            hour: hour,
            minute: minute,
            second: second,
            millisecond: millisecond,
            microsecond: microsecond,
            isUtc: false);

  final ConstructorType _constructorType;
  final int _year;
  final int _month;
  final int _day;
  final int _hour;
  final int _minute;
  final int _second;
  final int _millisecond;
  final int _microsecond;
  final bool _isUtc;

  const ConstDateTime.utc(int year,
      [int month = 1,
      int day = 1,
      int hour = 0,
      int minute = 0,
      int second = 0,
      int millisecond = 0,
      int microsecond = 0])
      : this._internal(ConstructorType.utc,
            year: year,
            month: month,
            day: day,
            hour: hour,
            minute: minute,
            second: second,
            millisecond: millisecond,
            microsecond: microsecond,
            isUtc: true);

  const ConstDateTime.fromMillisecondsSinceEpoch(int millisecondsSinceEpoch,
      {bool isUtc = false})
      : this._internal(ConstructorType.fromMillisecondsSinceEpoch,
            millisecond: millisecondsSinceEpoch, isUtc: isUtc);

  const ConstDateTime.fromMicrosecondsSinceEpoch(int microsecondsSinceEpoch,
      {bool isUtc = false})
      : this._internal(ConstructorType.fromMicrosecondsSinceEpoch,
            microsecond: microsecondsSinceEpoch, isUtc: isUtc);

  const ConstDateTime._internal(ConstructorType constructorType,
      {int year = 0,
      int month = 0,
      int day = 0,
      int hour = 0,
      int minute = 0,
      int second = 0,
      int millisecond = 0,
      int microsecond = 0,
      bool isUtc = false})
      : _constructorType = constructorType,
        _year = year,
        _month = month,
        _day = day,
        _hour = hour,
        _minute = minute,
        _second = second,
        _millisecond = millisecond,
        _microsecond = microsecond,
        _isUtc = isUtc;

  DateTime get dateTime {
    switch (_constructorType) {
      case ConstructorType.components:
        return DateTime(_year, _month, _day, _hour, _minute, _second,
            _millisecond, _microsecond);
      case ConstructorType.utc:
        return DateTime.utc(_year, _month, _day, _hour, _minute, _second,
            _millisecond, _microsecond);
      case ConstructorType.fromMillisecondsSinceEpoch:
        return DateTime.fromMillisecondsSinceEpoch(_millisecond, isUtc: _isUtc);
      case ConstructorType.fromMicrosecondsSinceEpoch:
        return DateTime.fromMicrosecondsSinceEpoch(_microsecond, isUtc: _isUtc);
    }
  }

  @override
  DateTime add(Duration duration) {
    return dateTime.add(duration);
  }

  @override
  int compareTo(DateTime other) {
    return dateTime.compareTo(other);
  }

  @override
  int get day => dateTime.day;

  @override
  Duration difference(DateTime other) {
    return dateTime.difference(other);
  }

  @override
  int get hashCode => dateTime.hashCode;

  @override
  int get hour => dateTime.hour;

  @override
  bool isAfter(DateTime other) {
    return dateTime.isAfter(other);
  }

  @override
  bool isAtSameMomentAs(DateTime other) {
    return dateTime.isAtSameMomentAs(other);
  }

  @override
  bool isBefore(DateTime other) {
    return dateTime.isBefore(other);
  }

  @override
  bool get isUtc => dateTime.isUtc;

  @override
  int get microsecond => dateTime.microsecond;

  @override
  int get microsecondsSinceEpoch => dateTime.microsecondsSinceEpoch;

  @override
  int get millisecond => dateTime.millisecond;

  @override
  int get millisecondsSinceEpoch => dateTime.millisecondsSinceEpoch;

  @override
  int get minute => dateTime.minute;

  @override
  int get month => dateTime.month;

  @override
  int get second => dateTime.second;

  @override
  DateTime subtract(Duration duration) {
    return dateTime.subtract(duration);
  }

  @override
  String get timeZoneName => dateTime.timeZoneName;

  @override
  Duration get timeZoneOffset => dateTime.timeZoneOffset;

  @override
  String toIso8601String() {
    return dateTime.toIso8601String();
  }

  @override
  DateTime toLocal() {
    return dateTime.toLocal();
  }

  @override
  DateTime toUtc() {
    return dateTime.toUtc();
  }

  @override
  int get weekday => dateTime.weekday;

  @override
  int get year => dateTime.year;

  @override
  bool operator ==(Object other) {
    return dateTime == other;
  }

  @override
  String toString() {
    return dateTime.toString();
  }

  @override
  dynamic noSuchMethod(Invocation invocation) {
    // Note: This solution is only valid on Flutter 3.3 / Dart 2.18
    //
    // On the Web platform, the [DateTime.difference] method reads the `other._value` variable internally.
    // ConstDateTime does not have a `_value` variable, which leads to errors when running
    // Returning [millisecondsSinceEpoch] in this case will prevent the error from being reported.
    //
    // @see https://github.com/dart-lang/sdk/blob/56e581aa3415858bbaf22bee23be705a68f8a03e/sdk/lib/_internal/js_runtime/lib/core_patch.dart#L342
    if (_kIsWeb && invocation.isGetter && !invocation.isSetter
        // Flutter web performs minified in release mode, resulting in not getting the correct memberName.
        /* && invocation.memberName == #_value */) {
      return dateTime.millisecondsSinceEpoch;
    }
    return super.noSuchMethod(invocation);
  }

  /// As `ConstDateTime` is a decorator type on top of `DateTime`
  /// we treat it as the ~same~ type for Equatability checks.
  @override
  Type get runtimeType => DateTime;
}

/// @see [kIsWeb](https://api.flutter.dev/flutter/foundation/kIsWeb-constant.html)
const bool _kIsWeb = identical(0, 0.0);
