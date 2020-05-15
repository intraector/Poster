import 'package:Poster/core/models/author.dart';
import 'package:Poster/core/models/post.dart';
import 'package:Poster/core/posts_repository_interface.dart';
import 'package:Poster/services/remote_db/srvc_remote_db.dart';

class RemoteDbAdapter implements PostsRepositoryInterface {
  var _serviceRemoteDb = SrvcRemoteDb();
  @override
  Future<List<Post>> fetchPosts() async {
    var result = await _serviceRemoteDb.fetchPosts();
    return result.map((postMap) => Post.fromMap(postMap)).toList();
  }

  @override
  Future<bool> savePosts(List<Post> entry) async {
    return true;
  }

  @override
  Future<Author> getAuthor(int userId) async {
    var result = await _serviceRemoteDb.getAuthor(userId);
    return Author.fromRemoteDb(result);
  }
}
