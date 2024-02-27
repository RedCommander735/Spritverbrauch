import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:icon_decoration/icon_decoration.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const Spritpreise());
}

class Spritpreise extends StatefulWidget {
  const Spritpreise({super.key});

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
  State<Spritpreise> createState() => _SpritpreiseState();
}

class _SpritpreiseState extends State<Spritpreise> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor:
          Theme.of(context).colorScheme.background, // Transparent status bar
      statusBarBrightness: Brightness.dark, // Dark text for status bar
      statusBarIconBrightness: Brightness.dark,
    ));
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    final PageController controller = PageController();

    return MaterialApp(
      theme: Spritpreise.themeLight,
      darkTheme: Spritpreise.themeDark,
      themeMode: ThemeMode.system,
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              print("pressed");
              print(MediaQuery.of(context).size.height);
            }),
        body: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: const PreferredSize(
              preferredSize: Size.fromHeight(60),
              child: SizedBox(
                height: 60,
                child: TabBar(
                  tabs: [
                    Tab(
                      icon: Icon(Icons.home),
                    ),
                    Tab(
                      icon: Icon(Icons.list),
                    )
                  ],
                ),
              ),
            ),
            body: TabBarView(
              physics: const ScrollPhysics(parent: ClampingScrollPhysics()),
              children: [
                Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 100),
                      child: Text(
                        "Overview",
                        style: TextStyle(fontSize: 34),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 80),
                        child: FractionallySizedBox(
                          widthFactor: 0.55,
                          child: Overview(),
                        ),
                      ),
                    )
                  ],
                ),
                const DetailsListView()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DetailsListView extends StatelessWidget {
  const DetailsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      addAutomaticKeepAlives: false,
      children: const [
        ListItem(),
        ListItem(),
        ListItem(),
        ListItem(),
        ListItem(),
        ListItem(),
        ListItem(),
        ListItem(),
        ListItem(),
        ListItem(),
        ListItem(),
        ListItem(),
        ListItem(),
        ListItem(),
        ListItem(),
        ListItem(),
        ListItem(),
        ListItem(),
        ListItem(),
        ListItem(),
        ListItem(),
        ListItem(),
        ListItem(),
        ListItem(),
        ListItem(),
        ListItem(),
        ListItem(),
        ListItem(),
        ListItem(),
        ListItem(),
        ListItem(),
        ListItem(),
        ListItem(),
        ListItem(),
        ListItem(),
        ListItem(),
        ListItem(),
        ListItem(),
        ListItem(),
        ListItem(),
        ListItem(),
      ],
    );
  }
}

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

class Overview extends StatefulWidget {
  static const padding = 10.0;

  static const textSize = 22.0;
  static const iconSize = textSize * 12 / 7;

  @override
  State<Overview> createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: Overview.textSize);

    return const Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        OverviewElement(
          "8,16 L/km",
          CompoundIcon(
            firstIcon: Icons.local_gas_station_outlined,
            secondIcon: Icons.route_outlined,
            size: Overview.iconSize,
          ),
          padding: Overview.padding,
          textStyle: textStyle,
          iconSize: Overview.iconSize,
        ),
        OverviewElement(
          "74,62 €",
          Icon(
            Icons.euro_outlined,
            size: Overview.iconSize,
          ),
          padding: Overview.padding,
          textStyle: textStyle,
          iconSize: Overview.iconSize,
        ),
        OverviewElement(
          "525,1 km",
          Icon(
            Icons.route_outlined,
            size: Overview.iconSize,
          ),
          padding: Overview.padding,
          textStyle: textStyle,
          iconSize: Overview.iconSize,
        ),
        OverviewElement(
          "1,74 €/L",
          CompoundIcon(
            firstIcon: Icons.local_gas_station_outlined,
            secondIcon: Icons.euro_outlined,
            size: Overview.iconSize,
          ),
          padding: Overview.padding,
          textStyle: textStyle,
          iconSize: Overview.iconSize,
        ),
        OverviewElement(
          "0,14 €/km",
          CompoundIcon(
            firstIcon: Icons.route_outlined,
            secondIcon: Icons.euro_outlined,
            size: Overview.iconSize,
          ),
          padding: Overview.padding,
          textStyle: textStyle,
          iconSize: Overview.iconSize,
        ),
      ],
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
                        width: size / 8)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
