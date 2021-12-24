final String tablePosts = 'posts';

class postFields {
  static final List<String> values = [id, idUsers, idPost, title, body];

  static final String id = '_id';
  static final String idUsers = 'idUsers';
  static final String idPost = 'idPost';
  static final String title = 'title';
  static final String body = 'body';
}

class PostsData {
  final int? id;
  final int idUsers;
  final int idPost;
  final String title;
  final String body;

  PostsData(
      {this.id,
      required this.idUsers,
      required this.idPost,
      required this.title,
      required this.body});

  PostsData copy(
          {int? id, int? idUsers, int? idPost, String? title, String? body}) =>
      PostsData(
          id: id ?? this.id,
          idUsers: idUsers ?? this.idUsers,
          idPost: idPost ?? this.idPost,
          title: title ?? this.title,
          body: body ?? this.body);

  static PostsData fromJson(Map<String, Object?> json) => PostsData(
      id: json[postFields.id] as int?,
      idUsers: json[postFields.idUsers] as int,
      idPost: json[postFields.idPost] as int,
      title: json[postFields.title] as String,
      body: json[postFields.body] as String);

  Map<String, Object?> toJson() => {
        postFields.id: id,
        postFields.idUsers: idUsers,
        postFields.idPost: idPost,
        postFields.title: title,
        postFields.body: body
      };
}
