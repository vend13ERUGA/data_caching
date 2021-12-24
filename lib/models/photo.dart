final String tablePhoto = 'photo';

class photoFields {
  static final List<String> values = [
    id,
    idUsers,
    idAlbum,
    idPhoto,
    title,
    url,
    thumbnailUrl
  ];

  static final String id = '_id';
  static final String idUsers = 'idUsers';
  static final String idAlbum = 'idAlbum';
  static final String idPhoto = 'idPhoto';
  static final String title = 'title';
  static final String url = 'url';
  static final String thumbnailUrl = 'thumbnailUrl';
}

class PhotosData {
  final int? id;
  final int idUsers;
  final int idAlbum;
  final int idPhoto;
  final String title;
  final String url;
  final String thumbnailUrl;

  PhotosData(
      {this.id,
      required this.idUsers,
      required this.idAlbum,
      required this.idPhoto,
      required this.title,
      required this.url,
      required this.thumbnailUrl});

  PhotosData copy(
          {int? id,
          int? idUsers,
          int? idAlbum,
          int? idPhoto,
          String? title,
          String? url,
          String? thumbnailUrl}) =>
      PhotosData(
          id: id ?? this.id,
          idUsers: idUsers ?? this.idUsers,
          idAlbum: idAlbum ?? this.idAlbum,
          idPhoto: idPhoto ?? this.idPhoto,
          title: title ?? this.title,
          url: url ?? this.url,
          thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl);

  static PhotosData fromJson(Map<String, Object?> json) => PhotosData(
      id: json[photoFields.id] as int?,
      idUsers: json[photoFields.idUsers] as int,
      idAlbum: json[photoFields.idAlbum] as int,
      idPhoto: json[photoFields.idPhoto] as int,
      title: json[photoFields.title] as String,
      url: json[photoFields.url] as String,
      thumbnailUrl: json[photoFields.thumbnailUrl] as String);

  Map<String, Object?> toJson() => {
        photoFields.id: id,
        photoFields.idUsers: idUsers,
        photoFields.idAlbum: idAlbum,
        photoFields.idPhoto: idPhoto,
        photoFields.title: title,
        photoFields.url: url,
        photoFields.thumbnailUrl: thumbnailUrl
      };
}
