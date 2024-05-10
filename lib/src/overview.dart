import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:spritverbrauch/src/filter/filter_model.dart';
import 'package:spritverbrauch/src/utils/compound_icon.dart';
import 'package:spritverbrauch/src/listview/item_list_model.dart';

class Overview extends StatelessWidget {
  static const padding = 10.0;

  static const textSize = 22.0;
  static const iconSize = textSize * 12 / 7;

  const Overview({super.key});

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: textSize);

    Provider.of<FilterModel>(context, listen: false).loadPreferences();

    return Consumer2<FilterModel, ItemListModel>(builder:
        (BuildContext context, FilterModel filterModel, ItemListModel itemListModel, Widget? child) {
      final filterEnabled = filterModel.filterEnabled;
      final dateFilter = filterModel.dateFilter;
      final startDateSingle = filterModel.startDateSingle;
      final startDate = filterModel.startDate;
      final endDate = filterModel.endDate;

      if (filterEnabled) {
        switch (dateFilter) {
          case DateFilter.fromDate:
            Provider.of<ItemListModel>(context, listen: false)
                .loadFiltered(startDateSingle);
            break;
          case DateFilter.dateRange:
            Provider.of<ItemListModel>(context, listen: false)
                .loadFiltered(startDate, end: endDate);
            break;
          default:
            Provider.of<ItemListModel>(context, listen: false)
                .loadFiltered(startDateSingle);
            break;
        }
      } else {
        Provider.of<ItemListModel>(context, listen: false).load();
      }

      var items = itemListModel.items;

      String lpk = "0.00";
      String price = "0.00";
      String dist = "0.00";
      String ppl = "0.00";
      String ppk = "0.00";

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

        String locale = Intl.systemLocale;
        var formatter = NumberFormat.decimalPatternDigits(
            decimalDigits: 2, locale: locale);

        lpk = formatter.format((litersPerKilometer.fold(
                0.0, (previousValue, element) => previousValue + element)) /
            litersPerKilometer.length);

        price = formatter.format((priceTotal.fold(
                0.0, (previousValue, element) => previousValue + element)) /
            priceTotal.length);

        dist = formatter.format((distance.fold(
                0.0, (previousValue, element) => previousValue + element)) /
            distance.length);

        ppl = formatter.format((priceTotal.fold(
                0.0, (previousValue, element) => previousValue + element)) /
            (liters.fold(
                0.0, (previousValue, element) => previousValue + element)));

        ppk = formatter.format((priceTotal.fold(
                0.0, (previousValue, element) => previousValue + element)) /
            (distance.fold(
                0.0, (previousValue, element) => previousValue + element)));
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
    });
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
