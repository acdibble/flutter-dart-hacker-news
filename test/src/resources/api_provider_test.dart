import 'package:news/src/resources/api_provider.dart';
import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main() {
  final api = ApiProvider();
  test('fetchTopIds returns list of ids', () async {
    List<int> ids = [1, 2, 3, 4];
    api.client = MockClient((req) async {
      return Response(json.encode(ids), 200);
    });

    final responseIds = await api.fetchTopIds();
    expect(ids, responseIds);
  });

  test('fetchItem returns an item model', () async {
    final Map<String, dynamic> jsonMap = {'id': 123, 'url': 'www.example.com'};
    api.client = MockClient((_) async {
      return Response(json.encode(jsonMap), 200);
    });

    final item = await api.fetchItem(jsonMap['id']);
    expect(jsonMap['url'], item.url);
    expect(jsonMap['id'], item.id);
  });
}
