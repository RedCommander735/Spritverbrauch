import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spritverbrauch/src/utils/sqlite_service.dart';

enum DateFilter { fromDate, dateRange }

const filterEnabledKey = 'filterEnabled';
const dateFilterKey = 'dateFilter';
const dateStartSingleKey = 'dateStartSingle';
const dateStartKey = 'dateStart';
const dateEndKey = 'dateEnd';

class FilterModel extends ChangeNotifier {
  late SharedPreferences preferences;

  bool _filterEnabled = false;
  DateFilter _dateFilter = DateFilter.fromDate;
  DateTime? _startDateSingle = DateTime(1970);
  DateTime _startDate = DateTime(1970);
  DateTime _endDate = DateTime.now();

  bool get filterEnabled => _filterEnabled;
  DateFilter get dateFilter => _dateFilter;
  DateTime? get startDateSingle => _startDateSingle;
  DateTime get startDate => _startDate;
  DateTime get endDate => _endDate;

  bool reset = false;

  void loadPreferences() async {
    preferences = await SharedPreferences.getInstance();

    // Filter Toggle
    var filterEnabledDb = preferences.getBool(filterEnabledKey);

    if (filterEnabledDb == null) {
      filterEnabledDb = false;
      preferences.setBool(filterEnabledKey, false);
    }

    _filterEnabled = filterEnabledDb;

    // Filter State
    var dateFilterDb = preferences.getString(dateFilterKey);

    if (dateFilterDb == null) {
      dateFilterDb = DateFilter.fromDate.toString();
      preferences.setString(dateFilterKey, DateFilter.fromDate.toString());
    }

    switch (dateFilterDb) {
      case 'DateFilter.fromDate':
        _dateFilter = DateFilter.fromDate;
        break;
      case 'DateFilter.dateRange':
        _dateFilter = DateFilter.dateRange;
        break;
    }

    // Value for fromDate Filter
    var dateStartSingleDb = preferences.getInt(dateStartSingleKey);

    _startDateSingle = (dateStartSingleDb == null)
        ? null
        : DateTime.fromMillisecondsSinceEpoch(dateStartSingleDb);

    // Start value for dateRange Filter
    var dateStartDb = preferences.getInt(dateStartKey);

    if (dateStartDb == null) {
      var sqlitesevice = SqliteService();
      var list = await sqlitesevice.getItems();

      dateStartDb = (list.isNotEmpty)
          ? list.last.date
          : DateTime.now().millisecondsSinceEpoch;
    }
    _startDate = DateTime.fromMillisecondsSinceEpoch(dateStartDb);

    // End value for dateRange Filter
    var dateEndDb = preferences.getInt(dateEndKey);

    dateEndDb ??= DateTime.now().millisecondsSinceEpoch;
    _endDate = DateTime.fromMillisecondsSinceEpoch(dateEndDb);

    notifyListeners();
  }

  /// Adds [item] to the list.
  void setFilterEnabled(bool enabled) {
    _filterEnabled = enabled;
    preferences.setBool(filterEnabledKey, enabled);

    if (reset) loadPreferences();

    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  /// Removes an items from the list.
  void setDateFilter(DateFilter filter) {
    _dateFilter = filter;
    preferences.setString(dateFilterKey, filter.toString());

    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  void setStartDateSingle(DateTime date) {
    _startDateSingle = date;
    preferences.setInt(dateStartSingleKey, date.millisecondsSinceEpoch);

    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  void setStartDate(DateTime date) {
    _startDate = date;
    preferences.setInt(dateStartKey, date.millisecondsSinceEpoch);

    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  void setEndDate(DateTime date) {
    _endDate = date;
    preferences.setInt(dateEndKey, date.millisecondsSinceEpoch);

    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  void resetFilter() {
    preferences.setBool(filterEnabledKey, false);
    preferences.setString(dateFilterKey, DateFilter.fromDate.toString());
    preferences.remove(dateStartSingleKey);
    preferences.remove(dateStartKey);
    preferences.remove(dateEndKey);

    _filterEnabled = false;
    _dateFilter = DateFilter.fromDate;

    reset = true;

    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}
