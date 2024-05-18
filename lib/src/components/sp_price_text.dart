import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spritverbrauch/src/utils/number_formatter.dart';

class SPPriceText extends StatelessWidget {
  final double value;
  final String unit;

  const SPPriceText({
    super.key,
    required this.value,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    String locale = Intl.systemLocale;

    final formatter = NumberFormatter(locale: locale);

    final FormattedDouble formatted = formatter.format(value);

    final normal = formatted.toString(roundLastDigit: false, fractionDigits: 2);
    final fraction = formatted.fractionalPartAsIntToString(fractionDigits: 3);

    var superscript = '';
    if (fraction.length > 2) {
      superscript = fraction.substring(2, 3);
    }

    return Text.rich(
      TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: [
          TextSpan(
            text: normal,
          ),
          WidgetSpan(
            child: Transform.translate(
              offset: Offset(
                  1.5, -DefaultTextStyle.of(context).style.fontSize! * 4 / 7),
              child: Text(
                superscript,
                style: TextStyle(
                    fontSize:
                        DefaultTextStyle.of(context).style.fontSize! * 5 / 7),
              ),
            ),
          ),
          TextSpan(
            text: ' $unit',
          ),
        ],
      ),
    );
  }
}
