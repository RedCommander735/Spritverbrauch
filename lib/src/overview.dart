import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:spritverbrauch/src/components/sp_price_text.dart';
import 'package:spritverbrauch/src/settings/filter_model.dart';
import 'package:spritverbrauch/src/components/sp_compound_icon.dart';
import 'package:spritverbrauch/src/listview/item_list_model.dart';

class Overview extends StatelessWidget {
  static const padding = 10.0;

  static const textSize = 22.0;
  static const iconSize = textSize * 12 / 7;

  const Overview({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<FilterModel>(context, listen: false).loadPreferences();

    return Consumer2<FilterModel, ItemListModel>(
        builder: (BuildContext context, FilterModel filterModel, ItemListModel itemListModel, Widget? child) {
      final filterEnabled = filterModel.filterEnabled;
      final dateFilter = filterModel.dateFilter;
      final startDateSingle = filterModel.startDateSingle;
      final startDate = filterModel.startDate;
      final endDate = filterModel.endDate;

      if (filterEnabled) {
        switch (dateFilter) {
          case DateFilter.fromDate:
            Provider.of<ItemListModel>(context, listen: false).loadFiltered(start: startDateSingle);
            break;
          case DateFilter.dateRange:
            Provider.of<ItemListModel>(context, listen: false).loadFiltered(start: startDate, end: endDate);
            break;
          default:
            Provider.of<ItemListModel>(context, listen: false).loadFiltered(start: startDateSingle);
            break;
        }
      } else {
        Provider.of<ItemListModel>(context, listen: false).load();
      }

      var items = itemListModel.items;

      double litersPerKilometerDisplay = 0;
      double priceDisplay = 0;
      double distanceDisplay = 0;
      double pricePerLiterDisplay = 0;
      double pricePerKilometerDisplay = 0;

      if (items.isNotEmpty) {
        List<double> litersPerKilometerDB = [];
        List<double> priceTotalDB = [];
        List<double> distanceDB = [];
        List<double> litersDB = [];

        for (var element in items) {
          litersPerKilometerDB.add(element.litersPerKilometer);
          priceTotalDB.add(element.priceTotal);
          distanceDB.add(element.distance);
          litersDB.add(element.fuelInLiters);
        }

        litersPerKilometerDisplay =
            (litersPerKilometerDB.fold(0.0, (previousValue, element) => previousValue + element)) /
                litersPerKilometerDB.length;

        priceDisplay =
            (priceTotalDB.fold(0.0, (previousValue, element) => previousValue + element)) / priceTotalDB.length;

        distanceDisplay =
            (distanceDB.fold(0.0, (previousValue, element) => previousValue + element)) / distanceDB.length;

        pricePerLiterDisplay = (priceTotalDB.fold(0.0, (previousValue, element) => previousValue + element)) /
            (litersDB.fold(0.0, (previousValue, element) => previousValue + element));

        pricePerKilometerDisplay = (priceTotalDB.fold(0.0, (previousValue, element) => previousValue + element)) /
            (distanceDB.fold(0.0, (previousValue, element) => previousValue + element));
      }

      return DefaultTextStyle(
        style: TextStyle(fontSize: textSize, color: Theme.of(context).colorScheme.onBackground),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Liter pro 100 km
            OverviewElement(
              value: litersPerKilometerDisplay,
              unit: 'L/km',
              icon: CompoundIcon(
                firstIcon: Icons.local_gas_station_rounded,
                secondIcon: Icons.route_rounded,
                size: iconSize,
              ),
              padding: padding,
              iconSize: iconSize,
            ),
            OverviewElement(
              value: priceDisplay,
              unit: '€',
              icon: const Icon(
                Icons.euro_rounded,
                size: iconSize,
              ),
              padding: padding,
              iconSize: iconSize,
              priceText: true,
            ),
            OverviewElement(
              value: distanceDisplay,
              unit: 'km',
              icon: const Icon(
                Icons.route_rounded,
                size: iconSize,
              ),
              padding: padding,
              iconSize: iconSize,
            ),
            OverviewElement(
              value: pricePerLiterDisplay,
              unit: '€/L',
              icon: CompoundIcon(
                firstIcon: Icons.local_gas_station_rounded,
                secondIcon: Icons.euro_rounded,
                size: iconSize,
                shape: CompoundIconClipShape.circle,
              ),
              padding: padding,
              iconSize: iconSize,
              priceText: true,
            ),
            OverviewElement(
              value: pricePerKilometerDisplay,
              unit: '€/km',
              icon: CompoundIcon(
                firstIcon: Icons.route_rounded,
                secondIcon: Icons.euro_rounded,
                size: iconSize,
                shape: CompoundIconClipShape.circle,
              ),
              padding: padding,
              iconSize: iconSize,
              priceText: true,
            ),
          ],
        ),
      );
    });
  }
}

class OverviewElement extends StatelessWidget {
  final double padding;
  final double iconSize;
  final double value;
  final String unit;
  final Widget icon; // Icon or CompoundIcon
  final bool priceText;

  const OverviewElement(
      {super.key,
      required this.value,
      required this.unit,
      required this.icon,
      this.padding = 10.0,
      this.iconSize = 24.0,
      this.priceText = false});

  @override
  Widget build(BuildContext context) {
    String locale = Intl.systemLocale;

    final formatter = NumberFormat.decimalPatternDigits(decimalDigits: 2, locale: locale);

    final textValue = formatter.format(value);

    return Padding(
      padding: EdgeInsets.all(padding),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          const Spacer(),
          if (!priceText)
            Text('$textValue $unit')
          else
            SPPriceText(
              value: value,
              unit: unit,
            )
        ],
      ),
    );
  }
}
