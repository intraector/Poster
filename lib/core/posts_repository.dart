import 'dart:async';
import 'package:Poster/core/models/author.dart';
import 'package:Poster/core/posts_repository_interface.dart';
import 'package:Poster/core/models/post.dart';

class PostsRepository {
  PostsRepository({this.remoteDb, this.localDb}) {
    var completer = Completer<bool>();
    initCompleted = completer.future;
    fetch().whenComplete(() => completer.complete(true));
  }

  final PostsRepositoryInterface remoteDb;
  final PostsRepositoryInterface localDb;

  var _cache = <Post>[];

  Future<bool> initCompleted;

  //-----------------------------------------
  Future fetch() async {
    var posts = await remoteDb.fetchPosts();
    await localDb.savePosts(posts);
    _cache = await localDb.fetchPosts();
  }

  //-----------------------------------------
  List<Post> get cache => _cache;

  //-----------------------------------------
  Future<Author> getAuthor(int userId) => remoteDb.getAuthor(userId);

  //-----------------------------------------
  Future fetchFromRemoteDb() async {
    _cache = await remoteDb.fetchPosts();
  }

  //-----------------------------------------
  Future fetchFromLocalDb() async {
    _cache = await localDb.fetchPosts();
  }
}
