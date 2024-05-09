import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:spritverbrauch/src/utils/sqlite_service.dart';

class ItemListModel extends ChangeNotifier {
  /// Internal, private state of the cart.
  List<ListItem> _items = [];
  
  /// An unmodifiable view of the items in the cart.
  UnmodifiableListView<ListItem> get items => UnmodifiableListView(_items);

  void load() async {
    var sqlitesevice = SqliteService();
    var list = await sqlitesevice.getItems();
    _items = list;
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  void loadFiltered(DateTime start, {DateTime? end}) async {
    var sqlitesevice = SqliteService();
    var list = await sqlitesevice.getItemsFiltered(start, end ?? DateTime.now());
    _items = list;
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  /// Adds [item] to the list.
  void add(ListItem item) {
    var sqlitesevice = SqliteService();
    sqlitesevice.createItem(item);
    _items.add(item);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  /// Removes an items from the list.
  void remove(ListItem item) {
    var sqlitesevice = SqliteService();
    sqlitesevice.deleteItem(item.id);
    _items.remove(item);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}
