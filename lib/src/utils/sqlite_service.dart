import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';

class SqliteService {
  Future<Database> _initDB() async {
    final database = openDatabase(
      join(await getDatabasesPath(), 'fuel_usage.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE IF NOT EXISTS fuel_usage(id INTEGER PRIMARY KEY AUTOINCREMENT, date INTEGER, distance DOUBLE, price DOUBLE, fuel_liters DOUBLE, price_liter DOUBLE, liters_kilometer DOUBLE)',
        );
      },
      version: 1,
    );
    return database;
  }

  Future<int> createItem(ListItem entity) async {
    final Database db = await _initDB();
    final id = await db.insert('fuel_usage', entity.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  Future<List<int>> createItems(List<ListItem> entitys) async {
    final Database db = await _initDB();
    List<int> ids = [];
    for (var entity in entitys) {
      int id = await db.insert('fuel_usage', entity.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
      ids.add(id);
    }
    return ids;
  }

  Future<List<ListItem>> getItems() async {
    final db = await _initDB();
    final List<Map<String, Object?>> queryResult = await db.query('fuel_usage', orderBy: 'date');
    final list = queryResult.map((e) => ListItem.fromMap(e)).toList();
    return list.reversed.toList();
  }

  Future<List<Map<String, Object?>>> getItemsAsMap() async {
    final db = await _initDB();
    final List<Map<String, Object?>> queryResult = await db.query('fuel_usage', orderBy: 'date');
    return queryResult.reversed.toList();
  }

  Future<List<ListItem>> getItemsFiltered(DateTime startingDate, DateTime endDate) async {
    final start = startingDate.millisecondsSinceEpoch;
    final end = endDate.millisecondsSinceEpoch;

    final db = await _initDB();
    final List<Map<String, Object?>> queryResult =
        await db.query('fuel_usage', orderBy: 'date', where: 'date >= ? AND date <= ?', whereArgs: [start, end]);
    final list = queryResult.map((e) => ListItem.fromMap(e)).toList();
    return list.reversed.toList();
  }

  Future<int> deleteItem(int id) async {
    final db = await _initDB();
    try {
      final count = await db.delete("fuel_usage", where: "id = ?", whereArgs: [id]);
      return count;
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
      return 0;
    }
  }

  Future<void> deleteAll() async {
    final db = await _initDB();
    try {
      await db.delete("fuel_usage");
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}

class ListItem {
  final int id;
  final int date;
  final double distance;
  final double priceTotal;
  final double fuelInLiters;
  final double pricePerLiter;
  final double litersPerKilometer;

  const ListItem({
    required this.id,
    required this.date,
    required this.distance,
    required this.priceTotal,
    required this.fuelInLiters,
    required this.pricePerLiter,
    required this.litersPerKilometer,
  });

  @override
  String toString() {
    return toMap().toString();
  }

  // Convert a ListEnty into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, Object?> toMap() {
    return {
      'date': date,
      'distance': distance,
      'price': priceTotal,
      'fuel_liters': fuelInLiters,
      'price_liter': pricePerLiter,
      'liters_kilometer': litersPerKilometer
    };
  }

  ListItem.fromMap(Map<String, dynamic> item)
      : id = item["id"],
        date = item["date"],
        distance = item['distance'],
        priceTotal = item['price'],
        fuelInLiters = item['fuel_liters'],
        pricePerLiter = item['price_liter'],
        litersPerKilometer = item['liters_kilometer'];
}
