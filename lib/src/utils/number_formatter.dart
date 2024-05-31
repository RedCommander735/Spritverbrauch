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
    if (fractionDigits != null) {
      return '$_integer$_decimalSeperator${fractionalPartAsIntToString(roundLastDigit: roundLastDigit, fractionDigits: fractionDigits).padRight(fractionDigits, '0')}';
    }

    return '$_integer$_decimalSeperator${fractionalPartAsIntToString(roundLastDigit: roundLastDigit, fractionDigits: fractionDigits)}';
  }

  String integerPartToString() {
    return _integer.toString();
  }

  String fractionalPartToString() {
    return '0$decimalSeperator${fractionalPartAsIntToString()}';
  }

  String fractionalPartAsIntToString({bool roundLastDigit = true, int? fractionDigits}) {
    late String fractionalString;

    if (fractionDigits != null && fractionDigits.isNegative) {
      throw const NegativeValue('Fractional digits cannot be negative');
    }

    if (fractionDigits != null && roundLastDigit) {
      fractionalString = _value.toStringAsFixed(fractionDigits).split('.').last.trimCharRight('0');
    } else if (fractionDigits != null && fractionDigits > 0 && !roundLastDigit) {
      String fracPart = _value.toString().split('.').last;
      fractionalString = (fracPart.length > fractionDigits) ? fracPart.substring(0, fractionDigits) : fracPart;
    } else if (fractionDigits != null && fractionDigits == 0 && !roundLastDigit) {
      return '';
    } else {
      fractionalString = _value.toString().split('.').last;
    }

    return fractionalString;
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

extension StringFuncs on String {
  String trimCharLeft(String pattern) {
    if (isEmpty || pattern.isEmpty || pattern.length > length) return this;
    var tmp = this;
    while (tmp.startsWith(pattern)) {
      tmp = tmp.substring(pattern.length);
    }
    return tmp;
  }

  String trimCharRight(String pattern) {
    if (isEmpty || pattern.isEmpty || pattern.length > length) return this;
    var tmp = this;
    while (tmp.endsWith(pattern)) {
      tmp = tmp.substring(0, tmp.length - pattern.length);
    }
    return tmp;
  }

  String trimChar(String pattern) {
    return trimCharLeft(pattern).trimCharRight(pattern);
  }
}
