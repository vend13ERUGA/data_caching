final String tableAlbum = 'album';

class albumFields {
  static final List<String> values = [id, idUsers, idAlbum, title];

  static final String id = '_id';
  static final String idUsers = 'idUsers';
  static final String idAlbum = 'idAlbum';
  static final String title = 'title';
}

class AlbumsData {
  final int? id;
  final int idUsers;
  final int idAlbum;
  final String title;

  AlbumsData(
      {this.id,
      required this.idUsers,
      required this.idAlbum,
      required this.title});

  AlbumsData copy({int? id, int? idUsers, int? idAlbum, String? title}) =>
      AlbumsData(
          id: id ?? this.id,
          idUsers: idUsers ?? this.idUsers,
          idAlbum: idAlbum ?? this.idAlbum,
          title: title ?? this.title);

  static AlbumsData fromJson(Map<String, Object?> json) => AlbumsData(
      id: json[albumFields.id] as int?,
      idUsers: json[albumFields.idUsers] as int,
      idAlbum: json[albumFields.idAlbum] as int,
      title: json[albumFields.title] as String);

  Map<String, Object?> toJson() => {
        albumFields.id: id,
        albumFields.idUsers: idUsers,
        albumFields.idAlbum: idAlbum,
        albumFields.title: title
      };
}
