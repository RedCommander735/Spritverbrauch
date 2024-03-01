import 'package:dynamic_color/dynamic_color.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:spritverbrauch/Overview.dart';
import 'package:spritverbrauch/DetailsView.dart';
import 'package:spritverbrauch/addItem.dart';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'dart:async';

void main() async {
  // Avoid errors caused by flutter upgrade.
// Importing 'package:flutter/widgets.dart' is required.
  WidgetsFlutterBinding.ensureInitialized();
// Open the database and store the reference.
  final database = openDatabase(
    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
    join(await getDatabasesPath(), 'fuel_usage.db'),
    // When the database is first created, create a table to store dogs.
    onCreate: (db, version) {
      // Run the CREATE TABLE statement on the database.
      return db.execute(
        'CREATE TABLE fuel(id INTEGER PRIMARY KEY, date DATETIME, distance DOUBLE, priceTotal DOUBLE, fuelInLiters DOUBLE, pricePerLiter DOUBLE, literPerKilometer DOUBLE)',
      );
    },
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    version: 1,
  );
  runApp(const Spritpreise());
}

class Spritpreise extends StatelessWidget {
  const Spritpreise({super.key});

  static final _defaultLightColorScheme = ColorScheme.fromSeed(
      seedColor: Colors.blue[900]!, brightness: Brightness.light);

  static final _defaultDarkColorScheme = ColorScheme.fromSeed(
      seedColor: Colors.blue[900]!, brightness: Brightness.dark);

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).platformBrightness == Brightness.light) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // Transparent status bar
        statusBarBrightness: Brightness.dark, // Dark text for status bar
        statusBarIconBrightness: Brightness.dark,
      ));
    } else {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // Transparent status bar
        statusBarBrightness: Brightness.light, // Dark text for status bar
        statusBarIconBrightness: Brightness.light,
      ));
    }
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    return DynamicColorBuilder(builder: (lightColorScheme, darkColorScheme) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: lightColorScheme ?? _defaultLightColorScheme,
          useMaterial3: true,
        ),
        darkTheme: ThemeData(
          colorScheme: darkColorScheme ?? _defaultDarkColorScheme,
          useMaterial3: true,
        ),
        themeMode: ThemeMode.system,
        home: Scaffold(
          floatingActionButton: Builder(
              builder: (context) => FloatingActionButton(
                    child: const Icon(Icons.add),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddItem()),
                      );
                    },
                  )),
          body: const SafeArea(
            child: DefaultTabController(
              length: 2,
              child: Scaffold(
                appBar: PreferredSize(
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
                  physics: ScrollPhysics(parent: ClampingScrollPhysics()),
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 100),
                          child: Text(
                            "Überblick",
                            style: TextStyle(fontSize: 34),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 80),
                            child: FractionallySizedBox(
                              widthFactor: 0.55,
                              child: Overview(),
                            ),
                          ),
                        )
                      ],
                    ),
                    DetailsListView()
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
