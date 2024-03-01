import 'package:flutter/material.dart';
import 'package:spritverbrauch/CompoundIcon.dart';

class Overview extends StatelessWidget {
  static const padding = 10.0;

  static const textSize = 22.0;
  static const iconSize = textSize * 12 / 7;

  const Overview({super.key});

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: textSize);

    return const Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        OverviewElement(
          "8,16 L/km",
          CompoundIcon(
            firstIcon: Icons.local_gas_station_outlined,
            secondIcon: Icons.route_outlined,
            size: iconSize,
          ),
          padding: padding,
          textStyle: textStyle,
          iconSize: iconSize,
        ),
        OverviewElement(
          "74,62 €",
          Icon(
            Icons.euro_outlined,
            size: iconSize,
          ),
          padding: padding,
          textStyle: textStyle,
          iconSize: iconSize,
        ),
        OverviewElement(
          "525,1 km",
          Icon(
            Icons.route_outlined,
            size: iconSize,
          ),
          padding: padding,
          textStyle: textStyle,
          iconSize: iconSize,
        ),
        OverviewElement(
          "1,74 €/L",
          CompoundIcon(
            firstIcon: Icons.local_gas_station_outlined,
            secondIcon: Icons.euro_outlined,
            size: iconSize,
          ),
          padding: padding,
          textStyle: textStyle,
          iconSize: iconSize,
        ),
        OverviewElement(
          "0,14 €/km",
          CompoundIcon(
            firstIcon: Icons.route_outlined,
            secondIcon: Icons.euro_outlined,
            size: iconSize,
          ),
          padding: padding,
          textStyle: textStyle,
          iconSize: iconSize,
        ),
      ],
    );
  }
}

class OverviewElement extends StatelessWidget {
  final double padding;
  final double iconSize;
  final TextStyle textStyle;
  final String text;
  final dynamic icon; // Icon or CompoundIcon

  const OverviewElement(this.text, this.icon,
      {super.key,
      this.padding = 10.0,
      this.iconSize = 24.0,
      this.textStyle = const TextStyle(fontSize: 14)});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          const Spacer(),
          Text(
            text,
            style: textStyle,
          )
        ],
      ),
    );
  }
}
