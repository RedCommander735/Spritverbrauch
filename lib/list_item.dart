import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spritverbrauch/compound_icon.dart';
import 'package:spritverbrauch/item_list_model.dart';
import 'package:spritverbrauch/sqlite_service.dart';

double roundDouble(double value, int places) {
  num mod = pow(10.0, places);
  return ((value * mod).round().toDouble() / mod);
}

class ListItem extends StatefulWidget {
  final ListEntity item;
  const ListItem({super.key, required this.item});

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  late ListEntity item;

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

    var litersPerKilometer = roundDouble(widget.item.litersPerKilometer, 2);

    var price = roundDouble(widget.item.priceTotal, 2);

    var distance = roundDouble(widget.item.distance, 2);

    var fuel = roundDouble(widget.item.fuelInLiters, 2);

    var pricePerLiter = roundDouble(widget.item.pricePerLiter, 3);

    return DefaultTextStyle(
      style: const TextStyle(fontSize: 16),
      child: GestureDetector(
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

                    Provider.of<ItemListModel>(context, listen: false)
                        .remove(item);

                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        },
        child: Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Column(
              children: [
                const Divider(),
                Padding(
                  padding: const EdgeInsets.only(top: 4, bottom: 4),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 7, bottom: 7),
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
                                  Text("$price €"),
                                ],
                              ),
                            )),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 7, bottom: 7),
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
                                    secondIcon:
                                        Icons.local_gas_station_outlined,
                                  ),
                                  const SizedBox(width: 2),
                                  Text("$pricePerLiter €"),
                                ],
                              ),
                            )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
