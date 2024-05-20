import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:spritverbrauch/src/components/font_awesome.dart';
import 'package:spritverbrauch/src/components/settings/settings_group.dart';
import 'package:spritverbrauch/src/components/settings/settings_item.dart';
import 'package:spritverbrauch/src/components/settings/settings_topic_page.dart';
import 'package:spritverbrauch/src/utils/url_launcher.dart';

class General extends StatefulWidget {
  General({super.key});

  @override
  State<General> createState() => _GeneralState();
}

class _GeneralState extends State<General> {
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
    return SettingsTopicPage(title: 'Informationen', children: [
      SettingsGroup(title: 'Backup', children: [
        SettingsItem(
          icon: Icons.save_rounded,
          title: 'Backup',
          subtitle: 'Als csv speichern',
          onTap: () {
          },
        ),
        SettingsItem(
          icon: Icons.upload_file_rounded,
          title: 'Laden',
          subtitle: 'Aus csv Datei laden',
          onTap: () {
          },
        ),
      ])
    ]);
  }
}
