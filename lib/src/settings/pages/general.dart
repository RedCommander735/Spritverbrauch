import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:spritverbrauch/src/components/font_awesome.dart';
import 'package:spritverbrauch/src/components/settings/settings_group.dart';
import 'package:spritverbrauch/src/components/settings/settings_item.dart';
import 'package:spritverbrauch/src/components/settings/settings_topic_page.dart';
import 'package:spritverbrauch/src/utils/csv_handler.dart';
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
          onTap: () async {
            final backupstorage = BackupStorage();
            bool success = await backupstorage.writeBackup();

            if (!success) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Zum speichern von Backups muss Zugriff auf Dateien gewährt sein."),
                showCloseIcon: true,
              ));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Datei erfolgreich im Downloads-Ordner gespeichert."),
                showCloseIcon: true,
              ));
            }
          },
        ),
        SettingsItem(
          icon: Icons.upload_file_rounded,
          title: 'Laden',
          subtitle: 'Aus csv Datei laden',
          onTap: () async {
            // TODO Implement file explorer
            final backupstorage = BackupStorage();
            bool success = await backupstorage.readBackup();

            if (!success) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Beim lesen der Datei ist ein Fehler aufgetreten."),
                showCloseIcon: true,
              ));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Das Backup wurde erfolgreich geladen."),
                showCloseIcon: true,
              ));
            }
          },
        ),
      ])
    ]);
  }
}
