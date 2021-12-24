import 'dart:convert';
import 'package:data_caching/models/users.dart';
import 'package:http/http.dart' as http;

Future<String> _loadJSON() async {
  var client = http.Client();
  Uri uri = Uri.parse('https://jsonplaceholder.typicode.com/users');
  var responce = await client.get(uri);
  return responce.body;
}

Future<List<UsersData>> loadJSON() async {
  String jsonString = await _loadJSON();
  List<UsersData> usersList = _parseJson(jsonString);
  return usersList;
}

List<UsersData> _parseJson(String jsonString) {
  var decoded = jsonDecode(jsonString);
  List<UsersData> items = [];
  decoded
      .map((json) => items.add(UsersData(
          idUsers: json['id'], name: json['name'], username: json['username'])))
      .toList();
  return items;
}
