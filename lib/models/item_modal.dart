import 'dart:convert';

class ItemModel {
  ItemModel.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson['id'] as int,
        deleted = parsedJson['deleted'] as bool,
        type = parsedJson['type'] as String,
        by = parsedJson['by'] as String,
        time = parsedJson['time'] as int,
        text = parsedJson['text'] as String,
        dead = parsedJson['dead'] as bool,
        parent = parsedJson['parent'] as int,
        kids = parsedJson['kids'] as List<int>,
        url = parsedJson['url'] as String,
        score = parsedJson['score'] as int,
        title = parsedJson['title'] as String,
        descendants = parsedJson['descendants'] as int;

  ItemModel.fromDb(Map<String, dynamic> dbObj)
      : id = dbObj['id'] as int,
        deleted = dbObj['deleted'] == 1,
        type = dbObj['type'] as String,
        by = dbObj['by'] as String,
        time = dbObj['time'] as int,
        text = dbObj['text'] as String,
        dead = dbObj['dead'] == 1,
        parent = dbObj['parent'] as int,
        kids = jsonDecode(dbObj['kids'] as String) as List<int>,
        url = dbObj['url'] as String,
        score = dbObj['score'] as int,
        title = dbObj['title'] as String,
        descendants = dbObj['descendants'] as int;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'type': type,
      'by': by,
      'time': time,
      'text': text,
      'parent': parent,
      'url': url,
      'score': score,
      'title': title,
      'descendants': descendants,
      'dead': dead ? 1 : 0,
      'deleted': deleted ? 1 : 0,
      'kids': jsonEncode(kids),
    };
  }

  final int id;
  final bool deleted;
  final String type;
  final String by;
  final int time;
  final String text;
  final bool dead;
  final int parent;
  final List<int> kids;
  final String url;
  final int score;
  final String title;
  final int descendants;
}
