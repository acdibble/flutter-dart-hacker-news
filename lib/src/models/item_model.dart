import 'dart:convert';

class ItemModel {
  final int id;
  final bool deleted;
  final String type;
  final String by;
  final int time;
  final String text;
  final bool dead;
  final int parent;
  final List<dynamic> kids;
  final String url;
  final int score;
  final String title;
  final int descendants;

  ItemModel.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson['id'],
        deleted = parsedJson['deleted'] ?? false,
        type = parsedJson['type'],
        by = parsedJson['by'] ?? '',
        time = parsedJson['time'],
        text = parsedJson['text'] ?? '',
        dead = parsedJson['dead'] ?? false,
        parent = parsedJson['parent'],
        kids = parsedJson['kids'] ?? [],
        url = parsedJson['url'],
        score = parsedJson['score'],
        title = parsedJson['title'],
        descendants = parsedJson['descendants'] ?? 0;

  ItemModel.fromDb(Map<String, dynamic> map)
      : id = map['id'],
        deleted = map['deleted'] == 1,
        type = map['type'],
        by = map['by'],
        time = map['time'],
        text = map['text'],
        dead = map['dead'] == 1,
        parent = map['parent'],
        kids = json.decode(map['kids']),
        url = map['url'],
        score = map['score'],
        title = map['title'],
        descendants = map['descendants'];

  Map<String, dynamic> toMapForDb() {
    return <String, dynamic>{
      'id': id,
      'deleted': deleted ? 1 : 0,
      'type': type,
      'by': by,
      'time': time,
      'text': text,
      'dead': dead ? 1 : 0,
      'parent': parent,
      'kids': json.encode(kids),
      'url': url,
      'score': score,
      'title': title,
      'descendants': descendants,
    };
  }
}
