import 'package:news/models/item_modal.dart';
import 'package:news/resources/news_api_provider.dart';
import 'package:news/resources/news_db_provider.dart';

class Repository {
  NewsDbProvider dbProvider = NewsDbProvider();
  NewsApiProvider newsApiProvider = NewsApiProvider();

  Future<List<int>> fetchTopIds() {
    return newsApiProvider.fetchTopIds();
  }

  Future<ItemModel> fetchItem(int id) async {
    var item = await dbProvider.fetchItem(id);

    if (item != null) {
      return item;
    }

    item = await newsApiProvider.fetchItemFromId(id);
    dbProvider.addItem(item);

    return item;
  }
}
