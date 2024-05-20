import 'package:dynamic_color/dynamic_color.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spritverbrauch/src/settings/filter_model.dart';

import 'package:spritverbrauch/src/listview/item_list_model.dart';
import 'package:spritverbrauch/src/listview/item_list_view.dart';
import 'package:spritverbrauch/src/overview.dart';
import 'package:spritverbrauch/src/add_item.dart';
import 'package:spritverbrauch/src/settings/filter.dart';

import 'package:provider/provider.dart';
import 'package:spritverbrauch/src/settings/settings.dart';
import 'package:spritverbrauch/src/settings/settings_model.dart';
import 'package:spritverbrauch/src/utils/licenses.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  addLicenses();

  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (BuildContext context) => ItemListModel()),
      ChangeNotifierProvider(create: (BuildContext context) => FilterModel()),
      ChangeNotifierProvider(create: (BuildContext context) => SettingsModel()),
    ], child: const Spritpreise()),
  );
}

class Spritpreise extends StatefulWidget {
  const Spritpreise({super.key});

  static final _defaultLightColorScheme = ColorScheme.fromSeed(
      seedColor: Colors.blue[900]!, brightness: Brightness.light);

  static final _defaultDarkColorScheme = ColorScheme.fromSeed(
      seedColor: Colors.blue[900]!, brightness: Brightness.dark, background: Colors.black);

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
          scaffoldBackgroundColor: Spritpreise._defaultLightColorScheme.background,
          useMaterial3: true,
        ),
        darkTheme: ThemeData(
          colorScheme: darkColorScheme ?? Spritpreise._defaultDarkColorScheme,
          appBarTheme: AppBarTheme(backgroundColor: Spritpreise._defaultDarkColorScheme.background),
          scaffoldBackgroundColor: Spritpreise._defaultDarkColorScheme.background,
          useMaterial3: true,
        ),
        themeMode: ThemeMode.system,
        home: const Main(),
      );
    });
  }
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Builder(
          builder: (context) => FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AddItem()),
                  );
                },
              )),
      body: SafeArea(
        child: DefaultTabController(
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
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Consumer2<FilterModel, ItemListModel>(
                        builder: (BuildContext context, FilterModel filterModel,
                            ItemListModel itemListModel, Widget? child) {
                          return Column(
                            children: [
                              Row(children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const Settings(),
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.settings),
                                ),
                                IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const Filter(),
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.tune),
                                ),
                                if (filterModel.filterEnabled)
                                  const Text(
                                    'Filter aktiv',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                if (filterModel.filterEnabled &&
                                    itemListModel.hiddenEntries > 0)
                                  Text(
                                    ', ausgeblendet: ${itemListModel.hiddenEntries}',
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                if (filterModel.filterEnabled)
                                  IconButton(
                                    onPressed: () {
                                      filterModel.setFilterEnabled(false);
                                    },
                                    icon: const Icon(Icons.close),
                                  ),
                              ]),
                            ],
                          );
                        },
                      ),
                    ),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Überblick",
                          style: TextStyle(fontSize: 34),
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
                  ],
                ),
                const ItemListView()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
