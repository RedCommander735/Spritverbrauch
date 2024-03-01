import 'package:flutter/material.dart';
import 'package:spritverbrauch/CompoundIcon.dart';

class ListItem extends StatelessWidget {
  const ListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTextStyle(
      style: TextStyle(fontSize: 16),
      child: Padding(
          padding: EdgeInsets.only(left: 5, right: 5),
          child: Column(
            children: [
              Divider(),
              Padding(
                padding: EdgeInsets.only(top: 4, bottom: 4),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 7, bottom: 7),
                      child: Row(
                        children: [
                          Expanded(
                              child: Row(
                            children: [
                              Icon(Icons.date_range_outlined),
                              SizedBox(width: 2),
                              Text("01.01.20XX"),
                            ],
                          )),
                          Expanded(
                              child: Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CompoundIcon(
                                  firstIcon: Icons.local_gas_station_outlined,
                                  secondIcon: Icons.route_outlined,
                                ),
                                SizedBox(width: 2),
                                Text("8,26 l/km"),
                              ],
                            ),
                          )),
                          Expanded(
                              child: Align(
                            alignment: Alignment.centerRight,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.euro_outlined),
                                SizedBox(width: 2),
                                Text("72,37 €"),
                              ],
                            ),
                          )),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 7, bottom: 7),
                      child: Row(
                        children: [
                          Expanded(
                              child: Row(
                            children: [
                              Icon(Icons.route_outlined),
                              SizedBox(width: 2),
                              Text("518 km"),
                            ],
                          )),
                          Expanded(
                              child: Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.local_gas_station_outlined),
                                SizedBox(width: 2),
                                Text("42,85 l"),
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
                                  firstIcon: Icons.euro_outlined,
                                  secondIcon: Icons.local_gas_station_outlined,
                                ),
                                SizedBox(width: 2),
                                Text("1,689 €"),
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
