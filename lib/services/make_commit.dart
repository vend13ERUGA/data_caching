import 'dart:collection';
import 'dart:convert';

import 'package:http/http.dart' as Http;

void pushCommit(String name, String mail, String commit, int ID) async {
  String urlStr = 'https://jsonplaceholder.typicode.com/posts/1/comments/';
  Uri url = Uri.parse(urlStr);
  Map<String, String> headers = new HashMap();
  headers['Accept'] = 'application/json';
  headers['Content-type'] = 'application/json';

  Http.Response response = await Http.post(url,
      headers: headers,
      body: jsonEncode(
          {'name': '$name', 'email': '$mail', 'body': '$commit', 'postId': ID}),
      encoding: Encoding.getByName('utf-8'));
}
