import 'dart:convert';
import 'package:data_caching/models/photo.dart';
import 'package:http/http.dart' as http;

Future<String> _loadJSON(int idAlbum, int page, int limit) async {
  var client = http.Client();
  Uri uri = Uri.parse(
      'https://jsonplaceholder.typicode.com/photos?albumId=$idAlbum&_page=$page&_limit=$limit');
  var responce = await client.get(uri);
  return responce.body;
}

Future<List<PhotosData>> loadJSONPhoto(
    int idAlbum, int page, int limit, int ID) async {
  String jsonString = await _loadJSON(idAlbum, page, limit);
  List<PhotosData> photoList = _parseJson(jsonString, ID);
  return photoList;
}

List<PhotosData> _parseJson(String jsonString, int ID) {
  var decoded = jsonDecode(jsonString);

  List<PhotosData> items = [];
  decoded
      .map((json) => items.add(PhotosData(
          idUsers: ID,
          idAlbum: json['albumId'],
          idPhoto: json['id'],
          title: json['title'],
          url: json['url'],
          thumbnailUrl: json['thumbnailUrl'])))
      .toList();
  return items;
}
