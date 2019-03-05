import 'dart:convert';

import 'package:http/http.dart' show Client;

import './repository.dart';
import '../models/item_model.dart';

class ApiProvider implements Source {
  Client client = Client();
  String _baseUrl = 'https://hacker-news.firebaseio.com/v0';

  Future<List<int>> fetchTopIds() async {
    final response = await client.get('$_baseUrl/topstories.json');
    return json.decode(response.body).cast<int>();
  }

  Future<ItemModel> fetchItem(int id) async {
    final response = await client.get('$_baseUrl/item/$id.json');
    return ItemModel.fromJson(json.decode(response.body));
  }
}
