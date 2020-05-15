import 'package:Poster/core/models/author.dart';
import 'package:Poster/core/models/post.dart';

abstract class PostsRepositoryInterface {
  Future<List<Post>> fetchPosts();
  Future<bool> savePosts(List<Post> posts);
  Future<Author> getAuthor(int userId);
}
