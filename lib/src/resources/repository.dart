import './api_provider.dart';
import './db_provider.dart';
import '../models/item_model.dart';

class Repository {
  List<Source> sources = <Source>[
    dbProvider,
    ApiProvider(),
  ];

  List<Cache> caches = <Cache>[
    dbProvider,
  ];

  Future<List<int>> fetchTopIds() {
    return sources[1].fetchTopIds();
  }

  Future<ItemModel> fetchItem(int id) async {
    ItemModel item;
    var source;

    for (source in sources) {
      item = await source.fetchItem(id);
      if (item != null) break;
    }

    for (final cache in caches) {
      if (cache != source) {
        cache.addItem(item);
      }
    }

    return item;
  }

  Future<void> clearCache() async {
    for (final cache in caches) {
      await cache.clear();
    }
  }
}

abstract class Source {
  Future<ItemModel> fetchItem(int id);
  Future<List<int>> fetchTopIds();
}

abstract class Cache {
  Future<int> addItem(ItemModel item);
  Future<void> clear();
}
