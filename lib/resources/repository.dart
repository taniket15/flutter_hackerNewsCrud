import 'package:news/models/item_modal.dart';
import 'package:news/resources/news_api_provider.dart';
import 'package:news/resources/news_db_provider.dart';

class Repository {
  List<Source> sources = <Source>[
    dbProvider,
    NewsApiProvider(),
  ];
  List<Cache> caches = <Cache>[
    dbProvider,
  ];

  Future<List<int>> fetchTopIds() {
    return sources[1].fetchTopIds();
  }

  Future<ItemModel> fetchItem(int id) async {
    ItemModel item;
    Source source;

    for (source in sources) {
      item = await source.fetchItem(id);
      if (item != null) {
        break;
      }
    }

    for (final Cache cache in caches) {
      cache.addItem(item);
    }

    return item;
  }
}

abstract class Source {
  Future<List<int>> fetchTopIds();
  Future<ItemModel> fetchItem(int id);
}

abstract class Cache {
  Future<int> addItem(ItemModel item);
}
