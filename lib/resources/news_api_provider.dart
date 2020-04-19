import 'dart:convert';
import 'package:http/http.dart' show Client, Response;

import 'package:news/models/item_modal.dart';
import 'package:news/resources/repository.dart';

const String baseUrl = 'https://hacker-news.firebaseio.com/v0';

class NewsApiProvider implements Source {
  Client client = Client();

  @override
  Future<List<int>> fetchTopIds() async {
    final Response response = await client.get('$baseUrl/topstories.json');
    final List<int> ids = json.decode(response.body) as List<int>;
    return ids;
  }

  @override
  Future<ItemModel> fetchItem(int id) async {
    final Response response = await client.get('$baseUrl/item/$id.json');
    final Map<String, dynamic> parsedJson =
        json.decode(response.body) as Map<String, dynamic>;
    return ItemModel.fromJson(parsedJson);
  }
}
