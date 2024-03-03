import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spritverbrauch/item_list_model.dart';
import 'package:spritverbrauch/list_item.dart';

class DetailsListView extends StatefulWidget {
  const DetailsListView({super.key});

  @override
  State<DetailsListView> createState() => DetailsListViewState();
}

class DetailsListViewState extends State<DetailsListView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ItemListModel>(
      builder: (BuildContext context, ItemListModel value, Widget? child) {
        var items = value.items;
        return FractionallySizedBox(
          widthFactor: 0.95,
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ListItem(item: items[index]);
            },
          ),
        );
      },
    );
  }
}
