import 'dart:convert';
import 'package:data_caching/models/post.dart';
import 'package:http/http.dart' as http;

Future<String> _loadJSON(int idUser, int page, int limit) async {
  var client = http.Client();
  Uri uri = Uri.parse(
      'https://jsonplaceholder.typicode.com/posts?userId=$idUser&_page=$page&_limit=$limit');
  var responce = await client.get(uri);
  return responce.body;
}

Future<List<PostsData>> loadJSONPost(int idUser, int page, int limit) async {
  String jsonString = await _loadJSON(idUser, page, limit);
  List<PostsData> postsList = _parseJson(jsonString);
  return postsList;
}

List<PostsData> _parseJson(String jsonString) {
  var decoded = jsonDecode(jsonString);

  List<PostsData> items = [];
  decoded
      .map((json) => items.add(PostsData(
          idUsers: json['userId'],
          idPost: json['id'],
          title: json['title'],
          body: json['body'])))
      .toList();
  return items;
}
