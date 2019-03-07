import 'package:flutter/material.dart';

import './screens/news_detail.dart';
import './screens/news_list.dart';
import 'blocs/comments_provider.dart';
import 'blocs/stories_provider.dart';

class App extends StatelessWidget {
  Widget build(BuildContext context) {
    return CommentsProvider(
      child: StoriesProvider(
        child: MaterialApp(
          title: 'News',
          onGenerateRoute: routes,
        ),
      ),
    );
  }

  Route routes(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(
        builder: (BuildContext context) {
          StoriesProvider.of(context).fetchTopIds();
          return NewsList();
        },
      );
    }

    return MaterialPageRoute(builder: (BuildContext context) {
      final itemId = int.parse(settings.name.substring(1));
      final bloc = CommentsProvider.of(context);
      bloc.fetchItemWithComments(itemId);
      return NewsDetail(itemId);
    });
  }
}
