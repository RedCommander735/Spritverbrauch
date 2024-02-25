import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:icon_decoration/icon_decoration.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red[900]!),
        useMaterial3: true,
      ),
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              print("pressed");
            }),
        body: ListView(
          children: const [
            FractionallySizedBox(
              heightFactor: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    // durchschnittlicher verbrauch
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.local_gas_station_outlined),
                      Text("8,16 L/km")
                    ],
                  ),
                  Row(
                    // durchschnittliche kosten
                    mainAxisSize: MainAxisSize.min,
                    children: [Icon(Icons.euro_outlined), Text("74,62 €")],
                  ),
                  Row(
                    // durchschnittlicher preis pro liter
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CompoundIcon(
                        firstIcon: Icons.local_gas_station_outlined,
                        secondIcon: Icons.euro_outlined,
                      ),
                      Text("1,74 €/L")
                    ],
                  ),
                  Row(
                    // durchschnittlicher preis pro kilometer
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CompoundIcon(
                          firstIcon: Icons.route_outlined,
                          secondIcon: Icons.euro_outlined),
                      Text("0,14 €/km")
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CompoundIcon extends StatelessWidget {
  final IconData firstIcon;
  final IconData secondIcon;
  final double size;

  const CompoundIcon(
      {super.key,
      required this.firstIcon,
      required this.secondIcon,
      this.size = 24});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(
                firstIcon,
                size: size,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              // decoration: const BoxDecoration(
              //     shape: BoxShape.circle, color: Colors.white),
              child: DecoratedIcon(
                icon: Icon(
                  secondIcon,
                  size: size * .55,
                ),
                decoration: IconDecoration(
                    border: IconBorder(color: Colors.white, width: size / 10)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
