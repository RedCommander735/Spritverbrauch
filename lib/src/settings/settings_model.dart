import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SettingsModel extends ChangeNotifier {
  // late SharedPreferences _preferences;

  bool _filterEnabled = false;

  bool get filterEnabled => _filterEnabled;

  bool reset = false;
}
