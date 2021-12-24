import 'dart:convert';
import 'package:data_caching/models/user_details.dart';
import 'package:http/http.dart' as http;

Future<String> _loadJSON(int userID) async {
  var client = http.Client();
  Uri uri = Uri.parse('https://jsonplaceholder.typicode.com/users?id=$userID');
  var responce = await client.get(uri);
  return responce.body;
}

Future<UserDetailData> loadJSON(int userID) async {
  String jsonString = await _loadJSON(userID);
  UserDetailData usersList = _parseJson(jsonString);
  return usersList;
}

UserDetailData _parseJson(String jsonString) {
  var json = jsonDecode(jsonString);
  UserDetailData items = UserDetailData(
      idUserDetails: json[0]['id'],
      email: json[0]['email'],
      phone: json[0]['phone'],
      website: json[0]['website'],
      companyName: json[0]['company']['name'],
      companyBs: json[0]['company']['bs'],
      companyCatchPhrase: json[0]['company']['catchPhrase'],
      street: json[0]['address']['street'],
      suite: json[0]['address']['suite'],
      city: json[0]['address']['city'],
      lat: json[0]['address']['geo']['lat'],
      lng: json[0]['address']['geo']['lng'],
      zipcode: json[0]['address']['zipcode']);
  return items;
}
