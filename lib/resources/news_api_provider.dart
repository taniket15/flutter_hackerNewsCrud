import 'package:http/http.dart' show Client;
import 'dart:convert';

import 'package:news/models/item_modal.dart';

const String baseUrl = "https://hacker-news.firebaseio.com/v0";

class NewsApiProvider {
  Client client = Client();

  Future<List<int>> fetchTopIds() async {
    final response = await client.get('$baseUrl/topstories.json');
    final ids = json.decode(response.body);
    return ids.cast<int>();
  }

  Future<ItemModel> fetchItemFromId(int id) async {
    final response = await client.get('$baseUrl/item/$id.json');
    final parsedJson = json.decode(response.body);
    return ItemModel.fromJson(parsedJson);
  }
}
