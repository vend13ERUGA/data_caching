import 'package:data_caching/pages/user_details.dart';
import 'package:data_caching/pages/users_list.dart';
import 'package:data_caching/database/database.dart';
import 'package:flutter/material.dart';

class MyHomeApp extends StatefulWidget {
  MyHomeApp({Key? key}) : super(key: key);

  @override
  _MyHomeAppState createState() => _MyHomeAppState();
}

class _MyHomeAppState extends State<MyHomeApp> {
  @override
  void initState() {
    initDB();
    super.initState();
  }

  @override
  void dispose() {
    DatabaseClass.instance.close();
    super.dispose();
  }

  Future initDB() async {
    await DatabaseClass.instance.initDB();
    setState(() {
      _ListOfUsers = UsersList();
    });
  }

  Widget _ListOfUsers = SizedBox(
    child: Center(
      child: CircularProgressIndicator(
        color: Colors.teal[900],
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _ListOfUsers,
    );
  }
}
