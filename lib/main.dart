import 'package:dynamic_color/dynamic_color.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:spritverbrauch/src/listview/item_list_model.dart';
import 'package:spritverbrauch/src/overview.dart';
import 'package:spritverbrauch/src/listview/item_list_view.dart';
import 'package:spritverbrauch/src/add_item.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (BuildContext context) => ItemListModel(),
      child: const Spritpreise()));
}

class Spritpreise extends StatefulWidget {
  const Spritpreise({super.key});

  static final _defaultLightColorScheme = ColorScheme.fromSeed(
      seedColor: Colors.blue[900]!, brightness: Brightness.light);

  static final _defaultDarkColorScheme = ColorScheme.fromSeed(
      seedColor: Colors.blue[900]!, brightness: Brightness.dark);

  @override
  State<Spritpreise> createState() => _SpritpreiseState();
}

class _SpritpreiseState extends State<Spritpreise> {
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

    Provider.of<ItemListModel>(context, listen: false).load();

    return DynamicColorBuilder(builder: (lightColorScheme, darkColorScheme) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: lightColorScheme ?? Spritpreise._defaultLightColorScheme,
          useMaterial3: true,
        ),
        darkTheme: ThemeData(
          colorScheme: darkColorScheme ?? Spritpreise._defaultDarkColorScheme,
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
                        MaterialPageRoute(
                            builder: (context) => const AddItem()),
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
                    ItemListView()
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
