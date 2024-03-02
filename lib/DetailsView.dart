import 'package:flutter/material.dart';
import 'package:spritverbrauch/ListItem.dart';
import 'package:spritverbrauch/sqlite_service.dart';

class DetailsListView extends StatefulWidget {
  const DetailsListView({super.key});

  @override
  State<DetailsListView> createState() => _DetailsListViewState();
}

class _DetailsListViewState extends State<DetailsListView> {
  late SqliteService _sqliteService;

  List<ListEntity> _items = [];

  @override
  void initState() {
    super.initState();
    _sqliteService = SqliteService();
    _sqliteService.initDB().whenComplete(() async {
      final data = await _sqliteService.getItems();
      setState(() {
        _items = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.95,
      child: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index) {
          return ListItem(item: _items[index]);
        },
      ),
    );
  }
}
