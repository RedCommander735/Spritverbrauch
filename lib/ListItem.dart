import 'package:flutter/material.dart';
import 'package:spritverbrauch/CompoundIcon.dart';
import 'package:spritverbrauch/sqlite_service.dart';

class ListItem extends StatelessWidget {
  final ListEntity item;
  const ListItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    var date = DateTime.fromMillisecondsSinceEpoch(item.date);
    var day = date.day.toString().padLeft(2, '0');
    var month = date.month.toString().padLeft(2, '0');
    var year = date.year.toString();

    var litersPerKilometer = item.litersPerKilometer;

    var price = item.priceTotal;

    var distance = item.distance;

    var fuel = item.fuelInLiters;

    var pricePerLiter = item.pricePerLiter;

    return DefaultTextStyle(
      style: const TextStyle(fontSize: 16),
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
                                  secondIcon: Icons.local_gas_station_outlined,
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
    );
  }
}
