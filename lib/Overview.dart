import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spritverbrauch/compound_icon.dart';
import 'package:spritverbrauch/item_list_model.dart';
import 'package:spritverbrauch/list_item.dart';

class Overview extends StatelessWidget {
  static const padding = 10.0;

  static const textSize = 22.0;
  static const iconSize = textSize * 12 / 7;

  const Overview({super.key});

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: textSize);
    Provider.of<ItemListModel>(context, listen: false).load();
    return Consumer<ItemListModel>(
      builder: (BuildContext context, ItemListModel value, Widget? child) {
        var items = value.items;

        double lpk = 0.0;
        double price = 0.0;
        double dist = 0.0;
        double ppl = 0.0;
        double ppk = 0.0;

        if (items.isNotEmpty) {
          List<double> litersPerKilometer = [];
          List<double> priceTotal = [];
          List<double> distance = [];
          List<double> liters = [];

          for (var element in items) {
            litersPerKilometer.add(element.litersPerKilometer);
            priceTotal.add(element.priceTotal);
            distance.add(element.distance);
            liters.add(element.fuelInLiters);
          }

          lpk = roundDouble(
              (litersPerKilometer.fold(0.0,
                      (previousValue, element) => previousValue + element)) /
                  litersPerKilometer.length *
                  100,
              2);

          price = roundDouble(
              (priceTotal.fold(0.0,
                      (previousValue, element) => previousValue + element)) /
                  priceTotal.length,
              2);

          dist = roundDouble(
              (distance.fold(0.0,
                      (previousValue, element) => previousValue + element)) /
                  distance.length,
              2);

          ppl = roundDouble(
              (priceTotal.fold(0.0,
                      (previousValue, element) => previousValue + element)) /
                  (liters.fold(0.0,
                      (previousValue, element) => previousValue + element)),
              3);

          ppk = roundDouble(
              (priceTotal.fold(0.0,
                      (previousValue, element) => previousValue + element)) /
                  (distance.fold(0.0,
                      (previousValue, element) => previousValue + element)),
              3);
        }

        return Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Liter pro 100 km
            OverviewElement(
              "$lpk L/km",
              const CompoundIcon(
                firstIcon: Icons.local_gas_station_outlined,
                secondIcon: Icons.route_outlined,
                size: iconSize,
              ),
              padding: padding,
              textStyle: textStyle,
              iconSize: iconSize,
            ),
            OverviewElement(
              "$price €",
              const Icon(
                Icons.euro_outlined,
                size: iconSize,
              ),
              padding: padding,
              textStyle: textStyle,
              iconSize: iconSize,
            ),
            OverviewElement(
              "$dist km",
              const Icon(
                Icons.route_outlined,
                size: iconSize,
              ),
              padding: padding,
              textStyle: textStyle,
              iconSize: iconSize,
            ),
            OverviewElement(
              "$ppl €/L",
              const CompoundIcon(
                firstIcon: Icons.local_gas_station_outlined,
                secondIcon: Icons.euro_outlined,
                size: iconSize,
              ),
              padding: padding,
              textStyle: textStyle,
              iconSize: iconSize,
            ),
            OverviewElement(
              "$ppk €/km",
              const CompoundIcon(
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
      },
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
