import 'package:data_caching/models/users.dart';
import 'package:data_caching/pages/user_details.dart';
import 'package:data_caching/services/users_parser.dart';
import 'package:flutter/material.dart';
import 'package:data_caching/database/database.dart';

class UsersList extends StatefulWidget {
  UsersList({Key? key}) : super(key: key);

  @override
  _UsersListState createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  Future<List<UsersData>> getUsers() async {
    var users = await DatabaseClass.instance.readAll();
    if (users.isEmpty) {
      users = await loadJSON();
      for (var item in users) {
        await DatabaseClass.instance.create(item);
      }
    }
    return users;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        title: Text("Список пользователей"),
        centerTitle: true,
        shadowColor: Colors.teal[900],
        backgroundColor: Colors.teal[900],
      ),
      body: Container(
        child: FutureBuilder<List<UsersData>>(
          future: getUsers(),
          builder:
              (BuildContext context, AsyncSnapshot<List<UsersData>> snapshot) {
            Widget children;
            if (snapshot.hasData) {
              children = ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    child: Card(
                      child: Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Text(snapshot.data![index].name),
                            Text(snapshot.data![index].username)
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserDetails(
                                  snapshot.data![index].idUsers,
                                  snapshot.data![index].name,
                                  snapshot.data![index].username))).then((_) {
                        setState(() {});
                      });
                    },
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
              );
            } else if (snapshot.hasError) {
              children = Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              );
            } else {
              children = Center(
                child: CircularProgressIndicator(
                  color: Colors.teal[900],
                ),
              );
            }
            return Center(
              child: children,
            );
          },
        ),
      ),
    );
  }
}
