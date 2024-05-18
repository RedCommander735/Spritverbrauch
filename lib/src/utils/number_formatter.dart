import 'package:intl/intl.dart';

class NumberFormatter {
  final String locale;

  NumberFormatter({required this.locale});

  FormattedDouble format(double value) {
    final format = NumberFormat.decimalPattern(locale);
    final decimalSeperator = format.symbols.DECIMAL_SEP;

    return FormattedDouble(value, decimalSeperator: decimalSeperator);
  }
}

class FormattedDouble {
  late double _value;
  late int _integer;
  late double _fractional;
  late String _decimalSeperator;

  FormattedDouble(this._value, {required String decimalSeperator}) {
    _decimalSeperator = decimalSeperator;
    _integer = _value.truncate();
    _fractional = _value - _integer;
  }

  set value(double value) {
    _value = value;
    _integer = _value.truncate();
    _fractional = _value - _integer;
  }

  set decimalSeperator(String decimalSeperator) {
    if (decimalSeperator.length > 1) {
      throw InvalidDecimalSeperator(
          'Decimal seperator \'$decimalSeperator\' is to long. Decimal seperator cannot be longer than one character.');
    } else {
      _decimalSeperator = decimalSeperator;
    }
  }

  double get value => _value;
  int get integerPart => _integer;
  double get fractionalPart => _fractional;
  String get decimalSeperator => _decimalSeperator;

  @override
  String toString({bool roundLastDigit = true, int? fractionDigits}) {
    return '$_integer$_decimalSeperator${fractionalPartAsInt(roundLastDigit: roundLastDigit, fractionDigits: fractionDigits)}';
  }

  String integerPartToString() {
    return _integer.toString();
  }

  String fractionalPartToString() {
    return '0$decimalSeperator${fractionalPartAsInt()}';
  }

  String fractionalPartAsIntToString({bool roundLastDigit = true, int? fractionDigits}) {
    return fractionalPartAsInt(roundLastDigit: roundLastDigit, fractionDigits: fractionDigits).toString();
  }

  int? fractionalPartAsInt({bool roundLastDigit = true, int? fractionDigits}) {
    late String fractionalString;

    if (fractionDigits != null && fractionDigits.isNegative) {
      throw const NegativeValue('Fractional digits cannot be negative');
    }

    if (fractionDigits != null && roundLastDigit) {
      fractionalString = _value.toStringAsFixed(fractionDigits).split('.').last;
    } else if (fractionDigits != null &&
        fractionDigits > 0 &&
        !roundLastDigit) {
      fractionalString =
          _value.toString().split('.').last.substring(0, fractionDigits);
    } else if (fractionDigits != null &&
        fractionDigits == 0 &&
        !roundLastDigit) {
      return null;
    } else {
      fractionalString = _value.toString().split('.').last;
    }
    final int fractionAsInt = int.parse(fractionalString);
    return fractionAsInt;
  }
}

class InvalidDecimalSeperator implements Exception {
  const InvalidDecimalSeperator([this.message]);

  final String? message;

  @override
  String toString() {
    String result = 'InvalidDecimalSeperator';
    if (message is String) return '$result: $message';
    return result;
  }
}

class NegativeValue implements Exception {
  const NegativeValue([this.message]);

  final String? message;

  @override
  String toString() {
    String result = 'NegativeValue';
    if (message is String) return '$result: $message';
    return result;
  }
}
