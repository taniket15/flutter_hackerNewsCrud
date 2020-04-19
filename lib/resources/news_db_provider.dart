import 'dart:io';

import 'package:news/models/item_modal.dart';
import 'package:news/resources/repository.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class NewsDbProvider implements Source, Cache {
  NewsDbProvider() {
    init();
  }

  Database db;

  Future<void> init() async {
    final Directory documentsDirectory =
        await getApplicationDocumentsDirectory();
    final String path = join(documentsDirectory.path, 'items.db');

    db = await openDatabase(path, version: 1,
        onCreate: (Database newDb, int version) {
      newDb.execute('''
          CREATE TABLE Items
            (
              id INTEGER PRIMARY KEY,
              type TEXT,
              by TEXT,
              time INTEGER,
              text TEXT,
              parent INTEGER,
              kids BLOB,
              dead INTEGER,
              deleted INTEGER,
              url TEXT,
              score INTEGER,
              title TEXT,
              descendants INTEGER
            )
        ''');
    });
  }

  @override
  Future<List<int>> fetchTopIds() async {
    return null;
  }

  @override
  Future<ItemModel> fetchItem(int id) async {
    final List<Map<String, dynamic>> maps = await db.query(
      'Items',
      columns: null,
      where: 'id =?',
      whereArgs: <dynamic>[id],
    );

    if (maps.isNotEmpty) {
      return ItemModel.fromDb(maps.first);
    }

    return null;
  }

  @override
  Future<int> addItem(ItemModel item) {
    return db.insert(
      'Items',
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }
}

final NewsDbProvider dbProvider = NewsDbProvider();
