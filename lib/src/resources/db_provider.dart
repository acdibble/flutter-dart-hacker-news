import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import './repository.dart';
import '../models/item_model.dart';

class DbProvider implements Cache, Source {
  Database db;

  DbProvider() {
    init();
  }

  Future<List<int>> fetchTopIds() {
    // TODO: implement
  }

  Future<void> init() async {
    final Directory docDir = await getApplicationDocumentsDirectory();
    final path = join(docDir.path, 'items.db');
    db = await openDatabase(
      path,
      version: 1,
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
      },
    );
  }

  Future<ItemModel> fetchItem(int id) async {
    final List<Map<String, dynamic>> maps = await db.query(
      'Items',
      columns: null,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.length > 0) {
      return ItemModel.fromDb(maps.first);
    }

    return null;
  }

  Future<int> addItem(ItemModel item) {
    return db.insert(
      'Items',
      item.toMapForDb(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<void> clear() {
    return db.delete('Items');
  }
}

final dbProvider = DbProvider();
