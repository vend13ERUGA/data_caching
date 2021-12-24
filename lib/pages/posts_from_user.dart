import 'package:data_caching/database/database.dart';
import 'package:data_caching/models/post.dart';
import 'package:data_caching/pages/post_detail.dart';
import 'package:data_caching/services/users_posts.dart';
import 'package:flutter/material.dart';

class PostFromUser extends StatefulWidget {
  int ID;
  PostFromUser(this.ID);

  @override
  _PostFromUserState createState() => _PostFromUserState(ID);
}

class _PostFromUserState extends State<PostFromUser> {
  bool activePage = true;
  List<PostsData> postList = [];
  int ID;
  _PostFromUserState(this.ID);
  late ScrollController _controller;
  int lengthInMoment = 0;

  void getPostFromLateDisplay() async {
    for (var i = lengthInMoment; i <= lengthInMoment + 3; i++) {
      var post = await loadJSONPost(ID, i, 1);
      if (post.isNotEmpty) {
        postList.add(post[0]);
        await DatabaseClass.instance.createPost(post[0]);
      }
    }
    if (lengthInMoment != (postList.length + 1) && activePage) {
      setState(() {});
    }
    lengthInMoment = postList.length + 1;
  }

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      getPostFromLateDisplay();
    }
  }

  void getPostList() async {
    var AllpostList = await DatabaseClass.instance.readAllPosts();
    for (var item in AllpostList) {
      if (item.idUsers == ID) {
        postList.add(item);
      }
    }
    if (postList.length == 3) {
      for (var i = 4; i < 6; i++) {
        var post = await loadJSONPost(ID, i, 1);
        postList.add(post[0]);
        await DatabaseClass.instance.createPost(post[0]);
      }
    }
    setState(() {});
    lengthInMoment = postList.length + 1;
  }

  @override
  void initState() {
    getPostList();
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    activePage = false;
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 40,
          title: Text("Посты"),
          centerTitle: true,
          shadowColor: Colors.teal[900],
          backgroundColor: Colors.teal[900],
        ),
        body: GridView.builder(
            controller: _controller,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: (2),
              crossAxisCount: 1,
            ),
            itemCount: postList.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                child: Card(
                  child: Container(
                    padding: EdgeInsets.all(40),
                    child: Column(
                      children: [
                        Text(
                          "Заголовок: " + postList[index].title,
                          style: TextStyle(fontSize: 20),
                        ),
                        Text("Пост: " + postList[index].body.split('\n')[0]),
                      ],
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              PostDetail(postList[index]))).then((_) {
                    setState(() {});
                  });
                },
              );
            }));
  }
}
