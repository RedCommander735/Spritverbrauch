import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:spritverbrauch/src/settings/filter_model.dart';
import 'package:spritverbrauch/src/settings/pages/about.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  void initState() {
    super.initState();
  }

  static const textSize = 18.0;

  @override
  Widget build(BuildContext context) {
    Provider.of<FilterModel>(context, listen: false).loadPreferences();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Einstellungen'),
        centerTitle: true,
      ),
      body: Consumer<FilterModel>(
        builder:
            (BuildContext context, FilterModel filterModel, Widget? child) {
          return DefaultTextStyle(
            style: TextStyle(
                fontSize: textSize,
                color: Theme.of(context).colorScheme.onBackground),
            child: Column(
              children: [
                const SettingsTopic(
                  icon: Icons.settings_outlined,
                  title: 'Allgemein',
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

class SettingsTopic extends StatelessWidget {
  const SettingsTopic({
    super.key,
    this.icon,
    this.title,
    this.onTap,
  });

  final IconData? icon;
  final String? title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (onTap == null) ? () {} : onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SizedBox(
          height: 64,
          child: Row(children: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Icon(icon),
            ),
            Text((title == null) ? '' : title!)
          ]),
        ),
      ),
    );
  }
}

class SettingsItem extends StatelessWidget {
  const SettingsItem({
    super.key,
    this.icon,
    this.title,
    this.subtitle,
    this.onTap,
  });

  final IconData? icon;
  final String? title;
  final String? subtitle;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (onTap == null) ? () {} : onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SizedBox(
          height: 72,
          child: Row(children: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Icon(icon),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null) Text(title!),
                if (subtitle != null)
                  Text(
                    subtitle!,
                    style: TextStyle(color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7)),
                  ),
              ],
            )
          ]),
        ),
      ),
    );
  }
}

class SettingsGroup extends StatelessWidget {
  const SettingsGroup({super.key, required this.title, required this.children});
  
  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.from([
        Text(title)
      ])..addAll(children),
    );
  }
  
}
// TODO Settings group (inspired by betteruntis settings small headers)