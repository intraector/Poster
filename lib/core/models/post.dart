import 'package:Poster/services/sqlite/sqlite_fields.dart';

class Post {
  int id;
  String title;
  String body;
  int userId;

  Post.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    body = map['body'];
    userId = map['userId'];
  }

  Map<String, dynamic> get toMap => {
        SqliteFieldsPosts.id: id,
        SqliteFieldsPosts.title: title,
        SqliteFieldsPosts.body: body,
        SqliteFieldsPosts.userId: userId,
      };
}
