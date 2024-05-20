import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:spritverbrauch/src/settings/settings.dart';

class About extends StatefulWidget {
  About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  String appName = '';
  String packageName = '';
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
      packageName = packageInfo.packageName;
      version = packageInfo.version;
      buildNumber = packageInfo.buildNumber;
    });
  }

  static const textSize = 16.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filter konfigurieren'),
        centerTitle: true,
      ),
      body: DefaultTextStyle(
            style: TextStyle(
                fontSize: textSize,
                color: Theme.of(context).colorScheme.onBackground),
            child: Column(
        children: [
          SettingsItem(
            icon: Icons.local_gas_station_outlined,
            title: appName,
            subtitle: 'Version $version ($buildNumber)',
          ),
        ],
      ),
    ),);
  }
}
