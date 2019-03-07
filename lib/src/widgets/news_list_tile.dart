import 'package:flutter/material.dart';

import 'loading_container.dart';
import '../blocs/stories_provider.dart';
import '../models/item_model.dart';

class NewsListTile extends StatelessWidget {
  final int itemId;

  NewsListTile({this.itemId});

  Widget build(BuildContext context) {
    final StoriesBloc bloc = StoriesProvider.of(context);

    return StreamBuilder(
      stream: bloc.items,
      builder: (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) {
          return LoadingContainer();
        }

        return FutureBuilder(
          future: snapshot.data[itemId],
          builder: (context, AsyncSnapshot<ItemModel> itemSnapshot) {
            if (!itemSnapshot.hasData) {
              return Container(
                height: 100.0,
              );
            }

            return buildTile(itemSnapshot.data, context);
          },
        );
      },
    );
  }

  Widget buildTile(ItemModel item, BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(item.title),
          subtitle: Text('${item.score} points'),
          trailing: Column(
            children: [
              Icon(Icons.chat_bubble),
              Text('${item.descendants}'),
            ],
          ),
          onTap: () {
            return Navigator.pushNamed(context, '/${item.id}');
          },
        ),
        Divider(
          height: 8.0,
        ),
      ],
    );
  }
}
