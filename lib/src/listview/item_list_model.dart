import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:spritverbrauch/src/utils/sqlite_service.dart';

class ItemListModel extends ChangeNotifier {
  late SqliteService _sqliteService;
  bool _sqliteInitialized = false;

  List<ListItem> _items = [];
  int _hiddenEntries = 0;

  bool _multiselect = false;
  ValueNotifier<bool> openCloseDial = ValueNotifier(false);
  int selected = 0;

  UnmodifiableListView<ListItem> get items => UnmodifiableListView(_items);
  int get hiddenEntries => _hiddenEntries;

  bool get multiselect => _multiselect;

  set multiselect(bool enabled) {
    if (!enabled) {
      deselectAll();
    } else {
      openCloseDial.value = true;
    }
    _multiselect = enabled;
  }

  void load() async {
    if (!_sqliteInitialized) {
      _sqliteService = SqliteService();
      _sqliteInitialized = true;
    }
    final list = await _sqliteService.getItems();
    _items = list;

    notifyListeners();
  }

  void loadFiltered({DateTime? start, DateTime? end}) async {
    final list = await _sqliteService.getItems();
    final listFiltered = await _sqliteService.getItemsFiltered(start ?? DateTime(1970), end ?? DateTime.now());
    _items = listFiltered;
    _hiddenEntries = list.length - listFiltered.length;

    notifyListeners();
  }

  void add(ListItem item) {
    _sqliteService.createItem(item);
    _items.add(item);

    notifyListeners();
  }

  void remove(List<ListItem> passedItems) {
    for (var item in passedItems) {
      _sqliteService.deleteItem(item.id);
      _items.remove(item);
    }
  }

  List<ListItem> get getSelected  {
    return UnmodifiableListView(_items.where((element) => element.selected));
  }

  void select(List<ListItem> passedItems) {
    for (var item in passedItems) {
      item.selected = !item.selected;

      if (item.selected) {
        selected += 1;
      } else {
        selected -= 1;
      }

      if (selected < 1) {
        _multiselect = false;
        openCloseDial.value = false;
      }
    }

    notifyListeners();
  }

  void deselectAll() {
    for (ListItem item in _items) {
      item.selected = false;
    }
    selected = 0;
    notifyListeners();
  }
}
