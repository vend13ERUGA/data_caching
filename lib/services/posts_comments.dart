import 'dart:convert';
import 'package:data_caching/models/comments.dart';
import 'package:http/http.dart' as http;

Future<String> _loadJSON(int postId) async {
  var client = http.Client();
  Uri uri =
      Uri.parse('https://jsonplaceholder.typicode.com/comments?postId=$postId');
  var responce = await client.get(uri);
  return responce.body;
}

Future<List<CommentsData>> loadJSONComments(int postId) async {
  String jsonString = await _loadJSON(postId);
  List<CommentsData> commentsList = _parseJson(jsonString);
  return commentsList;
}

List<CommentsData> _parseJson(String jsonString) {
  var decoded = jsonDecode(jsonString);

  List<CommentsData> items = [];
  decoded
      .map((json) => items.add(CommentsData(
          idPost: json['postId'],
          idComment: json['id'],
          name: json['name'],
          email: json['email'],
          body: json['body'])))
      .toList();
  return items;
}
