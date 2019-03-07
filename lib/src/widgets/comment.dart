import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';

import 'loading_container.dart';
import '../models/item_model.dart';

class Comment extends StatelessWidget {
  final int itemId;
  final Map<int, Future<ItemModel>> itemMap;
  final int depth;

  Comment(this.itemId, this.itemMap, {this.depth});

  Widget build(context) {
    return FutureBuilder(
      future: itemMap[itemId],
      builder: (context, AsyncSnapshot<ItemModel> snapshot) {
        if (!snapshot.hasData) return LoadingContainer();
        final item = snapshot.data;
        final children = <Widget>[
          ListTile(
            title: buildText(item.text),
            subtitle: Text(item.by == '' ? 'deleted' : item.by),
            contentPadding:
                EdgeInsets.only(left: 16.0 * (depth + 1), right: 16.0),
          ),
          Divider(),
        ];
        item.kids.forEach(
            (kidId) => children.add(Comment(kidId, itemMap, depth: depth + 1)));
        return Column(
          children: children,
        );
      },
    );
  }

  Widget buildText(String text) {
    final formatted = HtmlUnescape().convert(text).replaceAll('<p>', '\n\n');
    return Text(formatted);
  }
}
