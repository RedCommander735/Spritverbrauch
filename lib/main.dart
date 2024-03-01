import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spritverbrauch/Overview.dart';
import 'package:spritverbrauch/DetailsView.dart';
import 'package:spritverbrauch/addItem.dart';

void main() {
  runApp(const Spritpreise());
}

class Spritpreise extends StatelessWidget {
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

    return MaterialApp(
      theme: themeLight,
      darkTheme: themeDark,
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
  }
}
