import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spritverbrauch/src/listview/item_list_model.dart';
import 'package:spritverbrauch/src/listview/list_item.dart';

class ItemListView extends StatefulWidget {
  const ItemListView({super.key});

  @override
  State<ItemListView> createState() => ItemListViewState();
}

class ItemListViewState extends State<ItemListView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ItemListModel>(builder: (BuildContext context, ItemListModel value, Widget? child) {
      var items = value.items;
      return ListView.separated(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListEntry(item: items[index]);
        },
        separatorBuilder: (context, build) => const Divider(height: 1),
      );
    });
  }
}
