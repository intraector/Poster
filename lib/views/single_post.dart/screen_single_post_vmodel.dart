import 'dart:async';
import 'package:Poster/core/models/author.dart';
import 'package:Poster/core/posts_repository.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class ScreenSinglePostVModel {
  final _repo = getIt<PostsRepository>();

  Future<Author> getAuthor(int userId) => _repo.getAuthor(userId);
}
