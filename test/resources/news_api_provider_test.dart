import 'package:flutter_test/flutter_test.dart';
import 'package:news/models/item_modal.dart';
import 'package:news/resources/news_api_provider.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main() {
  test('fetchTopIds retuns a list of ids', () async {
    final newsApi = NewsApiProvider();
    newsApi.client = MockClient((request) async {
      return Response(json.encode([1, 2, 3]), 200);
    });

    final ids = await newsApi.fetchTopIds();

    expect(ids, [1, 2, 3]);
  });

  test('fetchItemFromId retuns a item object', () async {
    final newsApi = NewsApiProvider();
    newsApi.client = MockClient((request) async {
      final jsonMap = {'id': 12345};
      return Response(json.encode(jsonMap), 200);
    });

    final item = await newsApi.fetchItemFromId(12345) as ItemModel;

    expect(item.id, 12345);
  });
}
