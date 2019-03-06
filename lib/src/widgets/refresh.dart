import 'package:flutter/material.dart';

import '../blocs/stories_provider.dart';

class Refresh extends StatelessWidget {
  final ListView listView;

  Refresh(this.listView);

  Widget build(context) {
    final bloc = StoriesProvider.of(context);
    return RefreshIndicator(
      child: listView,
      onRefresh: () {
        return bloc.clearCache();
      },
    );
  }
}
