import 'package:rxdart/rxdart.dart';

import '../models/item_model.dart';
import '../resources/repository.dart';

class CommentsBloc {
  final _repo = Repository();
  final _commentsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();
  final _commentsFetcher = PublishSubject<int>();

  CommentsBloc() {
    _commentsFetcher.stream
        .transform(_commentsTransformer())
        .pipe(_commentsOutput);
  }

  Observable<Map<int, Future<ItemModel>>> get itemWithComments =>
      _commentsOutput.stream;
  Function(int) get fetchItemWithComments => _commentsFetcher.sink.add;

  _commentsTransformer() {
    return ScanStreamTransformer(
      (Map<int, Future<ItemModel>> acc, int id, int index) {
        acc[id] = _repo.fetchItem(id);
        acc[id].then((ItemModel item) {
          item.kids.forEach((kidId) => fetchItemWithComments(kidId));
        });
        return acc;
      },
      <int, Future<ItemModel>>{},
    );
  }

  dispose() {
    _commentsOutput.close();
    _commentsFetcher.close();
  }
}
