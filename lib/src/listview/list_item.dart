import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:spritverbrauch/src/components/sp_compound_icon.dart';
import 'package:spritverbrauch/src/components/sp_price_text.dart';
import 'package:spritverbrauch/src/listview/item_list_model.dart';
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
    var date = DateTime.fromMillisecondsSinceEpoch(widget.item.date);
    var day = date.day.toString().padLeft(2, '0');
    var month = date.month.toString().padLeft(2, '0');
    var year = date.year.toString();

    String locale = Intl.systemLocale;
    var formatter = NumberFormat.decimalPatternDigits(decimalDigits: 2, locale: locale);

    var litersPerKilometer = formatter.format(widget.item.litersPerKilometer);

    var price = widget.item.priceTotal;

    var distance = formatter.format(widget.item.distance);

    var fuel = formatter.format(widget.item.fuelInLiters);

    var pricePerLiter = widget.item.pricePerLiter;

    return DefaultTextStyle(
      style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.onBackground),
      child: InkWell(
        onLongPress: () {
          showDialog<void>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Eintrag löschen?'),
              content: const Text('Diesen Eintrag wirklich löschen?'),
              actions: [
                TextButton(
                  child: const Text('Abbrechen'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('Bestätigen'),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Eintrag entfernt"),
                      showCloseIcon: true,
                    ));

                    Provider.of<ItemListModel>(context, listen: false).remove(item);

                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        },
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
                        const Icon(Icons.date_range_outlined),
                        const SizedBox(width: 2),
                        Text("$day.$month.$year"),
                      ],
                    )),
                    Expanded(
                        child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const CompoundIcon(
                            firstIcon: Icons.local_gas_station_outlined,
                            secondIcon: Icons.route_outlined,
                          ),
                          const SizedBox(width: 2),
                          Text("$litersPerKilometer l/km"),
                        ],
                      ),
                    )),
                    Expanded(
                        child: Align(
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.euro_outlined),
                          const SizedBox(width: 2),
                          SPPriceText(value: price, unit: '€'),
                        ],
                      ),
                    )),
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
                        const Icon(Icons.route_outlined),
                        const SizedBox(width: 2),
                        Text("$distance km"),
                      ],
                    )),
                    Expanded(
                        child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.local_gas_station_outlined),
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
                            const CompoundIcon(
                              firstIcon: Icons.euro_outlined,
                              secondIcon: Icons.local_gas_station_outlined,
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
    );
  }
}
