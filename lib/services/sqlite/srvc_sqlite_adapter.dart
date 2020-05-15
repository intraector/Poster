import 'package:Poster/core/models/author.dart';
import 'package:Poster/core/models/post.dart';
import 'package:Poster/core/posts_repository_interface.dart';
import 'package:Poster/services/sqlite/srvc_sqlite.dart';

class SqliteAdapater implements PostsRepositoryInterface {
  var _serviceSqlite = SrvcSqlite();

  Future<List<Post>> fetchPosts() async {
    var result = await _serviceSqlite.fetchPosts();
    return result.map((post) => Post.fromMap(post)).toList();
  }

  Future<bool> savePosts(List<Post> posts) async =>
      _serviceSqlite.savePosts(posts.map((e) => e.toMap));

  Future<Author> getAuthor(int userId) {
    return null;
  }
}
