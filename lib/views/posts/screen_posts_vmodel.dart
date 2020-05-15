import 'dart:async';
import 'package:Poster/core/models/post.dart';
import 'package:Poster/core/posts_repository.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class ScreenPostsVModel {
  ScreenPostsVModel() {
    initCompleted = _repo.initCompleted;
    initCompleted.whenComplete(() => cache = _repo.cache);
  }

  var cache = <Post>[];
  final _repo = getIt<PostsRepository>();
  Future<bool> initCompleted;
}
