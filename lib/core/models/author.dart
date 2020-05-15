class Author {
  String name;
  String username;
  String email;

  Author.fromRemoteDb(Map<String, dynamic> json) {
    name = json['name'];
    username = json['username'];
    email = json['email'];
  }
}
