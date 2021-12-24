import 'dart:convert';
import 'package:data_caching/models/album.dart';
import 'package:http/http.dart' as http;

Future<String> _loadJSON(int idUser, int page, int limit) async {
  var client = http.Client();
  Uri uri = Uri.parse(
      'https://jsonplaceholder.typicode.com/posts?userId=$idUser&_page=$page&_limit=$limit');
  var responce = await client.get(uri);
  return responce.body;
}

Future<List<AlbumsData>> loadJSONAlbum(int idUser, int page, int limit) async {
  String jsonString = await _loadJSON(idUser, page, limit);
  List<AlbumsData> albumList = _parseJson(jsonString);
  return albumList;
}

List<AlbumsData> _parseJson(String jsonString) {
  var decoded = jsonDecode(jsonString);

  List<AlbumsData> items = [];
  decoded
      .map((json) => items.add(AlbumsData(
          idUsers: json['userId'], idAlbum: json['id'], title: json['title'])))
      .toList();
  return items;
}
