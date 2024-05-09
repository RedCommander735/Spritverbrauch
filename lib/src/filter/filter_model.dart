import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spritverbrauch/src/utils/sqlite_service.dart';

enum DateFilter { fromDate, dateRange }

class FilterModel extends ChangeNotifier {
  
  late SharedPreferences preferences;
  

  bool _filterEnabled = false;

  DateFilter _dateFilter = DateFilter.fromDate;

  
  bool get filterEnabled => _filterEnabled;

  DateFilter get dateFilter => _dateFilter;


  void loadPreferences() async {
    preferences = await SharedPreferences.getInstance();

    var filterEnabledDb = preferences.getBool('filterEnabled');

    if (filterEnabledDb == null) {
      filterEnabledDb = false;
      preferences.setBool('filterEnabled', false);
    }

    _filterEnabled = filterEnabledDb;


    var dateFilterDb = preferences.getString('dateFilter');

    if (dateFilterDb == null) {
      dateFilterDb = DateFilter.fromDate.toString();
      preferences.setString('dateFilter', DateFilter.fromDate.toString());
    }

    switch (dateFilterDb) {
      case 'DateFilter.fromDate':
        _dateFilter = DateFilter.fromDate;
        break;
      case 'DateFilter.dateRange':
        _dateFilter = DateFilter.dateRange;
        break;
      default:
        _dateFilter = DateFilter.fromDate;
    }
    notifyListeners();
  }

  /// Adds [item] to the list.
  void setFilterEnabled(bool enabled) {
    _filterEnabled = enabled;
    preferences.setBool('filterEnabled', (enabled));

    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  /// Removes an items from the list.
  void setDateFilter(DateFilter filter) {
    _dateFilter = filter;
    preferences.setString('dateFilter', filter.toString());

    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}