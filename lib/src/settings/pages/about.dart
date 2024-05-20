import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:spritverbrauch/src/components/font_awesome.dart';
import 'package:spritverbrauch/src/components/settings/settings_group.dart';
import 'package:spritverbrauch/src/components/settings/settings_item.dart';
import 'package:spritverbrauch/src/components/settings/settings_topic_page.dart';
import 'package:spritverbrauch/src/utils/url_launcher.dart';

class About extends StatefulWidget {
  About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  String appName = '';
  String version = '';
  String buildNumber = '';

  @override
  void initState() {
    super.initState();
    asyncInitState();
  }

  void asyncInitState() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    setState(() {
      appName = packageInfo.appName;
      version = packageInfo.version;
      buildNumber = packageInfo.buildNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SettingsTopicPage(
      title: 'Informationen',
      children: [
      SettingsItem(
        icon: Icons.local_gas_station_outlined,
        title: appName,
        subtitle: 'Version $version ($buildNumber)',
        onTap: () {
          Uri url = Uri.parse('https://github.com/RedCommander735/Spritverbrauch/releases/');
          launchURL(url);
        },
      ),
      SettingsGroup(title: 'General', children: [
        SettingsItem(
          icon: FontAwesomeBrands.github,
          title: 'GitHub repository',
          subtitle: 'https://github.com/RedCommander735/\nSpritverbrauch',
          onTap: () {
            Uri url = Uri.parse('https://github.com/RedCommander735/Spritverbrauch/');
            launchURL(url);
          },
        ),
        SettingsItem(
          icon: FontAwesomeBrands.github,
          title: 'License',
          subtitle: 'GPL-3.0',
          onTap: () {
            Uri url = Uri.parse('https://github.com/RedCommander735/Spritverbrauch/blob/main/LICENSE');
            launchURL(url);
          },
        ),
        SettingsItem(
          icon: Icons.extension_outlined,
          title: 'Libraries',
          subtitle: 'A list of all used libraries',
          onTap: () {
            showLicensePage(
                context: context,
                applicationName: appName,
                applicationVersion: '$version ($buildNumber)',
                applicationLegalese: 'Copyright (C) 2024  RedCommander735');
          },
        ),
      ])
    ]);
  }
}
