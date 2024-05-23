import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:spritverbrauch/src/components/sp_compound_icon.dart';
import 'package:spritverbrauch/src/components/sp_price_text.dart';
import 'package:spritverbrauch/src/listview/item_list_model.dart';
import 'package:spritverbrauch/src/settings/filter_model.dart';
import 'package:spritverbrauch/src/utils/sqlite_service.dart';

double roundDouble(double value, int places) {
  num mod = pow(10.0, places);
  return ((value * mod).round().toDouble() / mod);
}

class ListEntry extends StatefulWidget {
  final ListItem item;
  const ListEntry({super.key, required this.item});

  @override
  State<ListEntry> createState() => _ListEntryState();
}

class _ListEntryState extends State<ListEntry> {
  late ListItem item;


  @override
  void initState() {
    super.initState();
    setState(() {
      item = widget.item;
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(item.date);
    String day = date.day.toString().padLeft(2, '0');
    String month = date.month.toString().padLeft(2, '0');
    String year = date.year.toString();

    String locale = Intl.systemLocale;
    NumberFormat formatter = NumberFormat.decimalPatternDigits(decimalDigits: 2, locale: locale);

    String litersPerKilometer = formatter.format(item.litersPerKilometer);

    double price = item.priceTotal;

    String distance = formatter.format(item.distance);

    String fuel = formatter.format(item.fuelInLiters);

    double pricePerLiter = item.pricePerLiter;

    bool highlighted = item.selected;

    return DefaultTextStyle(
      style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.onBackground),
      child: InkWell(
        onLongPress: () {
          bool multiselect = Provider.of<ItemListModel>(context, listen: false).multiselect;
          if (!multiselect) {
            Provider.of<ItemListModel>(context, listen: false).multiselect = true;
            Provider.of<ItemListModel>(context, listen: false).select(item);
          } else {
            Provider.of<ItemListModel>(context, listen: false).select(item);
          }
        },
        onTap: () {
          bool multiselect = Provider.of<ItemListModel>(context, listen: false).multiselect;
          if (multiselect) {
            Provider.of<ItemListModel>(context, listen: false).select(item);
          }
        },
        splashColor: (highlighted) ? Colors.transparent : null,
        child: Container(
          color: (highlighted) ? Color.lerp(Colors.white, Colors.transparent, 0.55) : Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 15),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  child: Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            const Icon(Icons.date_range_rounded),
                            const SizedBox(width: 2),
                            Text("$day.$month.$year"),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CompoundIcon(
                                firstIcon: Icons.local_gas_station_rounded,
                                secondIcon: Icons.route_rounded,
                              ),
                              const SizedBox(width: 2),
                              Text("$litersPerKilometer l/km"),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.euro_rounded),
                              const SizedBox(width: 2),
                              SPPriceText(value: price, unit: '€'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  child: Row(
                    children: [
                      Expanded(
                          child: Row(
                        children: [
                          const Icon(Icons.route_rounded),
                          const SizedBox(width: 2),
                          Text("$distance km"),
                        ],
                      )),
                      Expanded(
                          child: Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.local_gas_station_rounded),
                            const SizedBox(width: 2),
                            Text("$fuel l"),
                          ],
                        ),
                      )),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CompoundIcon(
                                firstIcon: Icons.euro_rounded,
                                secondIcon: Icons.local_gas_station_rounded,
                              ),
                              const SizedBox(width: 2),
                              SPPriceText(value: pricePerLiter, unit: '€'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
