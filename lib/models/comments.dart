final String tableComment = 'comment';

class commentFields {
  static final List<String> values = [id, idPost, idComment, name, email, body];

  static final String id = '_id';
  static final String idPost = 'idPost';
  static final String idComment = 'idComment';
  static final String name = 'name';
  static final String email = 'email';
  static final String body = 'body';
}

class CommentsData {
  final int? id;
  final int idPost;
  final int idComment;
  final String name;
  final String email;
  final String body;

  CommentsData(
      {this.id,
      required this.idPost,
      required this.idComment,
      required this.name,
      required this.email,
      required this.body});

  CommentsData copy(
          {int? id,
          int? idPost,
          int? idComment,
          String? name,
          String? email,
          String? body}) =>
      CommentsData(
          id: id ?? this.id,
          idPost: idPost ?? this.idPost,
          idComment: idComment ?? this.idComment,
          name: name ?? this.name,
          email: email ?? this.email,
          body: body ?? this.body);

  static CommentsData fromJson(Map<String, Object?> json) => CommentsData(
      id: json[commentFields.id] as int?,
      idPost: json[commentFields.idPost] as int,
      idComment: json[commentFields.idComment] as int,
      name: json[commentFields.name] as String,
      email: json[commentFields.email] as String,
      body: json[commentFields.body] as String);

  Map<String, Object?> toJson() => {
        commentFields.id: id,
        commentFields.idPost: idPost,
        commentFields.idComment: idComment,
        commentFields.name: name,
        commentFields.email: email,
        commentFields.body: body
      };
}
