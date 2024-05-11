import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spritverbrauch/src/utils/sqlite_service.dart';

enum DateFilter { fromDate, dateRange }

class FilterModel extends ChangeNotifier {
  
  late SharedPreferences preferences;
  
  bool _filterEnabled = false;
  DateFilter _dateFilter = DateFilter.fromDate;
  DateTime _startDateSingle = DateTime(1970);
  DateTime _startDate = DateTime(1970);
  DateTime _endDate = DateTime.now();

  bool get filterEnabled => _filterEnabled;
  DateFilter get dateFilter => _dateFilter;
  DateTime get startDateSingle => _startDateSingle;
  DateTime get startDate => _startDate;
  DateTime get endDate => _endDate;

  void loadPreferences() async {
    preferences = await SharedPreferences.getInstance();

    // Filter Toggle
    var filterEnabledDb = preferences.getBool('filterEnabled');

    if (filterEnabledDb == null) {
      filterEnabledDb = false;
      preferences.setBool('filterEnabled', false);
    }

    _filterEnabled = filterEnabledDb;

    // Filter State
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

    // Value for fromDate Filter
    var dateStartSingleDb = preferences.getInt('dateStartSingle');

    if (dateStartSingleDb == null) {
      var sqlitesevice = SqliteService();
      var list = await sqlitesevice.getItems();

      dateStartSingleDb = (list.isNotEmpty) ? list.last.date : DateTime.now().millisecondsSinceEpoch;
      preferences.setInt('dateStartSingle', dateStartSingleDb);
    }

    _startDateSingle = DateTime.fromMillisecondsSinceEpoch(dateStartSingleDb);

    // Start value for dateRange Filter
    var dateStartDb = preferences.getInt('dateStart');

    if (dateStartDb == null) {
      var sqlitesevice = SqliteService();
      var list = await sqlitesevice.getItems();

      dateStartDb = (list.isNotEmpty) ? list.last.date : DateTime.now().millisecondsSinceEpoch;
      preferences.setInt('dateStart', dateStartDb);
    }

    _startDate = DateTime.fromMillisecondsSinceEpoch(dateStartDb);

    // End value for dateRange Filter
    var dateEndDb = preferences.getInt('dateEnd');

    if (dateEndDb == null) {
      dateEndDb = DateTime.now().millisecondsSinceEpoch;
      preferences.setInt('dateEnd', dateEndDb);
    }

    _endDate = DateTime.fromMillisecondsSinceEpoch(dateEndDb);

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

  void setStartDateSingle(DateTime date) {
    _startDateSingle = date;
    preferences.setInt('dateStartSingle', date.millisecondsSinceEpoch);

    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  void setStartDate(DateTime date) {
    _startDate = date;
    preferences.setInt('dateStart', date.millisecondsSinceEpoch);

    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  void setEndDate(DateTime date) {
    _endDate = date;
    preferences.setInt('dateEnd', date.millisecondsSinceEpoch);

    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}