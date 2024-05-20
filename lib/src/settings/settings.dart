import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spritverbrauch/src/components/settings/settings_topic.dart';

import 'package:spritverbrauch/src/settings/filter_model.dart';
import 'package:spritverbrauch/src/settings/pages/about.dart';
import 'package:spritverbrauch/src/settings/pages/general.dart';

class Settings extends StatefulWidget {
  const Settings({super.key, this.textSize = 18});

  final double textSize;

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<FilterModel>(context, listen: false).loadPreferences();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Einstellungen'),
        centerTitle: true,
      ),
      body: Consumer<FilterModel>(
        builder: (BuildContext context, FilterModel filterModel, Widget? child) {
          return DefaultTextStyle(
            style: TextStyle(fontSize: widget.textSize, color: Theme.of(context).colorScheme.onBackground),
            child: Column(
              children: [
                SettingsTopic(
                  icon: Icons.settings_rounded,
                  title: 'Allgemein',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => General(),
                      ),
                    );
                  },
                ),
                SettingsTopic(
                  icon: Icons.info_outline,
                  title: 'Informationen',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => About(),
                      ),
                    );
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
