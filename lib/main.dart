import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:icon_decoration/icon_decoration.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final themeLight = ThemeData(
    colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.red[900]!, brightness: Brightness.light),
    useMaterial3: true,
  );

  static final themeDark = ThemeData(
    colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.red[900]!, brightness: Brightness.dark),
    useMaterial3: true,
  );

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor:
          Theme.of(context).colorScheme.background, // Transparent status bar
      statusBarBrightness: Brightness.dark, // Dark text for status bar
      statusBarIconBrightness: Brightness.dark,
    ));
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    return MaterialApp(
      theme: themeLight,
      darkTheme: themeDark,
      themeMode: ThemeMode.system,
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              print("pressed");
              print(MediaQuery.of(context).size.height);
            }),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: FractionallySizedBox(
                child: Overview(),
                widthFactor: 0.6,
              ),
            ),
            Container(
              color: Colors.amber,
              height: 100,
            )
          ],
        ),
      ),
    );
  }
}

class Overview extends StatelessWidget {
  static const padding = 10.0;

  static const textSize = 24.0;
  static const iconSize = textSize * 12 / 7;

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: textSize);

    return SizedBox(
      height: MediaQuery.of(context).size.height -
          MediaQuery.of(context).viewPadding.top,
      child: const Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          OverviewElement(
            "8,16 L/km",
            Icon(
              Icons.local_gas_station_outlined,
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
      ),
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
        // durchschnittlicher verbrauch
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

class CompoundIcon extends StatelessWidget {
  final IconData firstIcon;
  final IconData secondIcon;
  final double size;
  final double scalar;

  const CompoundIcon({
    super.key,
    required this.firstIcon,
    required this.secondIcon,
    this.size = 24,
    this.scalar = 1,
  });

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
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
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
                    border: IconBorder(
                        color: Theme.of(context).colorScheme.background,
                        width: size / 10)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
