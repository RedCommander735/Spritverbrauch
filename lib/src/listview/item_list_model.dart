import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:spritverbrauch/src/utils/sqlite_service.dart';

class ItemListModel extends ChangeNotifier {
  /// Internal, private state of the cart.
  List<ListEntity> _items = [];

  /// An unmodifiable view of the items in the cart.
  UnmodifiableListView<ListEntity> get items => UnmodifiableListView(_items);

  void load() async {
    var sqlitesevice = SqliteService();
    var list = await sqlitesevice.getItems();
    _items = list;
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  /// Adds [item] to cart. This and [removeAll] are the only ways to modify the
  /// cart from the outside.
  void add(ListEntity item) {
    var sqlitesevice = SqliteService();
    sqlitesevice.createItem(item);
    _items.add(item);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  /// Removes all items from the cart.
  void remove(ListEntity item) {
    var sqlitesevice = SqliteService();
    sqlitesevice.deleteItem(item.id);
    _items.remove(item);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}
