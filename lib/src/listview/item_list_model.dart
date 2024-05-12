import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:spritverbrauch/src/utils/sqlite_service.dart';

class ItemListModel extends ChangeNotifier {
  /// Internal, private state of the cart.
  List<ListItem> _items = [];
  int _filteredHidden = 0;
  
  /// An unmodifiable view of the items in the cart.
  UnmodifiableListView<ListItem> get items => UnmodifiableListView(_items);
  int get filteredHidden => _filteredHidden;

  void load() async {
    final sqlitesevice = SqliteService();
    final list = await sqlitesevice.getItems();
    _items = list;
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  void loadFiltered({DateTime? start, DateTime? end}) async {
    final sqlitesevice = SqliteService();
    final list = await sqlitesevice.getItems();
    final listFiltered = await sqlitesevice.getItemsFiltered(start ?? DateTime(1970), end ?? DateTime.now());
    _items = listFiltered;
    _filteredHidden = list.length - listFiltered.length;
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  /// Adds [item] to the list.
  void add(ListItem item) {
    final sqlitesevice = SqliteService();
    sqlitesevice.createItem(item);
    _items.add(item);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  /// Removes an items from the list.
  void remove(ListItem item) {
    final sqlitesevice = SqliteService();
    sqlitesevice.deleteItem(item.id);
    _items.remove(item);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}
