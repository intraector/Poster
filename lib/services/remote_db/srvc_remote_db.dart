import 'package:http/http.dart' as http;
import 'dart:convert';

class SrvcRemoteDb {
  String _urlPosts = 'https://jsonplaceholder.typicode.com/posts';
  String _urlAuthors = 'https://jsonplaceholder.typicode.com/users/';

  Future<List> fetchPosts() async {
    final response = await http.get(_urlPosts);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load posts');
    }
  }

  Future<Map> getAuthor(int userId) async {
    final response = await http.get(_urlAuthors + userId.toString());

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load author');
    }
  }
}
