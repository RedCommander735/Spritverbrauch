import 'dart:io';

import 'package:csv/csv.dart';
import 'package:spritverbrauch/src/utils/sqlite_service.dart';
import 'package:permission_handler/permission_handler.dart';

class BackupStorage {
  Future<String> get _localPath async {

    Directory dir = Directory('/storage/emulated/0/Download/spritverbrauch');
    dir.create();

    print(dir.path);

    return dir.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/backup.csv');
  }

  Future<File> get _localBackupFile async {
    final path = await _localPath;
    return File('$path/backup-before-load.csv');
  }

  Future<bool> readBackup() async {
    writeBackup(beforeLoad: true);

    try {
      final file = await _localFile;

      late String contents;
      // Read the file
      var status = await Permission.manageExternalStorage.status;

      if (status.isPermanentlyDenied) {
        return false;
      }
      if (status.isDenied) {
        status = await Permission.manageExternalStorage.request();
        if (status.isPermanentlyDenied) {
          return false;
        } else if (status.isGranted) {
          contents = await file.readAsString();
        }
      }
      if (status.isGranted) {
        contents = await file.readAsString();
      }

      if (contents.isEmpty) {
        return false;
      }

      CsvMapConverter converter = CsvMapConverter();
      SqliteService sqlite = SqliteService();

      List<Map<String, dynamic>> itemMaps = converter.convertCsvToMaps(contents);

      var listItems = itemMaps.map((e) => ListItem.fromMap(e)).toList();

      sqlite.deleteAll();

      sqlite.createItems(listItems);

      return true;

    } catch (e) {
      // If encountering an error, return 0
      return false;
    }
  }

  Future<bool> writeBackup({bool beforeLoad = false}) async {
    final file = (beforeLoad) ? await _localBackupFile : await _localFile;

    CsvMapConverter converter = CsvMapConverter();
    SqliteService sqlite = SqliteService();

    late String csv;

    final maps = await sqlite.getItemsAsMap(); 
    if (maps.isNotEmpty) {
      csv = converter.convertMapsToCsv(maps);
    } else {
      csv = '';
    }

    // Write the file
    var status = await Permission.manageExternalStorage.status;

    if (status.isPermanentlyDenied) {
      return false;
    }
    if (status.isDenied) {
      status = await Permission.manageExternalStorage.request();
      if (status.isPermanentlyDenied) {
        return false;
      } else if (status.isGranted) {
        file.writeAsString(csv);
        return true;
      }
    }
    if (status.isGranted) {
      file.writeAsString(csv);
      return true;
    }
    return false;
  }
}

class CsvMapConverter {
  late CsvToListConverter csvToListConverter;
  late ListToCsvConverter listToCsvConverter;

  CsvMapConverter() {
    csvToListConverter = const CsvToListConverter();
    listToCsvConverter = const ListToCsvConverter();
  }

  List<Map<String, dynamic>> convertCsvToMaps(String csv) {
    List<List<dynamic>> list = csvToListConverter.convert(csv);
    List legend = list[0];
    List<Map<String, dynamic>> maps = [];
    list.sublist(1).forEach((List l) {
      Map<String, dynamic> map = {};
      for (int i = 0; i < legend.length; i++) {
        map.putIfAbsent('${legend[i]}', () => l[i]);
      }
      maps.add(map);
    });
    return maps;
  }

    String convertMapsToCsv(List<Map<String, dynamic>> maps) {
    List legend = maps[0].keys.toList();
    List<List<dynamic>> lists = [legend];
    for (var m in maps) {
      List<dynamic> list = m.values.toList();
      lists.add(list);
    }

    String csv = listToCsvConverter.convert(lists);
    return csv;
  }
}