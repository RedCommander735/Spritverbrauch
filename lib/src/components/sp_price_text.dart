import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

    final formatter =
        NumberFormat.decimalPatternDigits(decimalDigits: 2, locale: locale);

    final String normal = formatter.format(value);
    final decimal = value.toString().split('.')[1];

    var superscript = '';
    if (decimal.length > 2) {
      superscript = decimal.substring(2, 3);
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
