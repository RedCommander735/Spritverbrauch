import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:spritverbrauch/src/utils/sqlite_service.dart';

class ItemListModel extends ChangeNotifier {
  
  List<ListItem> _items = [];
  int _hiddenEntries = 0;


  UnmodifiableListView<ListItem> get items => UnmodifiableListView(_items);
  int get hiddenEntries => _hiddenEntries;

  void load() async {
    final sqlitesevice = SqliteService();
    final list = await sqlitesevice.getItems();
    _items = list;
    
    notifyListeners();
  }

  void loadFiltered({DateTime? start, DateTime? end}) async {
    final sqlitesevice = SqliteService();
    final list = await sqlitesevice.getItems();
    final listFiltered = await sqlitesevice.getItemsFiltered(start ?? DateTime(1970), end ?? DateTime.now());
    _items = listFiltered;
    _hiddenEntries = list.length - listFiltered.length;
    
    notifyListeners();
  }


  void add(ListItem item) {
    final sqlitesevice = SqliteService();
    sqlitesevice.createItem(item);
    _items.add(item);
    
    notifyListeners();
  }


  void remove(ListItem item) {
    final sqlitesevice = SqliteService();
    sqlitesevice.deleteItem(item.id);
    _items.remove(item);
    
    notifyListeners();
  }
}
