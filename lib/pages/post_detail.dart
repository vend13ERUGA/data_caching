import 'package:data_caching/database/database.dart';
import 'package:data_caching/models/comments.dart';
import 'package:data_caching/models/post.dart';
import 'package:data_caching/services/make_commit.dart';
import 'package:data_caching/services/posts_comments.dart';
import 'package:flutter/material.dart';

class PostDetail extends StatefulWidget {
  PostsData postList;
  PostDetail(this.postList);

  @override
  _PostDetailState createState() => _PostDetailState(postList);
}

class _PostDetailState extends State<PostDetail> {
  PostsData postList;
  _PostDetailState(this.postList);
  String name = '';
  String mail = '';
  String commets = '';
  Future<List<CommentsData>> getComment() async {
    List<CommentsData> commentsList =
        await DatabaseClass.instance.readAllComments();
    var presence =
        commentsList.any((element) => element.idPost == postList.idPost);
    if (!presence) {
      var comment = await loadJSONComments(postList.idPost);
      for (var item in comment) {
        await DatabaseClass.instance.createComment(item);
        commentsList.add(item);
      }
    }
    List<CommentsData> commentsListInId = [];
    for (var item in commentsList) {
      if (item.idPost == postList.idPost) {
        commentsListInId.add(item);
      }
    }

    return commentsListInId;
  }

  void showPurchaseDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Введите имя",
                    ),
                    onChanged: (text) {
                      name = text;
                    }),
                TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Введите email",
                    ),
                    onChanged: (text) {
                      mail = text;
                    }),
                TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: 4,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Введите комментарий",
                    ),
                    onChanged: (text) {
                      commets = text;
                    }),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('Закрыть'),
              ),
              TextButton(
                onPressed: () {
                  pushCommit(name, mail, commets, postList.idPost);
                  Navigator.pop(context, 'OK');
                },
                child: const Text('Отправить'),
              ),
            ],
          );
        });
  }

  double getScreenHeight() {
    var padding = MediaQuery.of(context).padding;
    double height =
        MediaQuery.of(context).size.height - padding.top - kToolbarHeight;
    return height;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        title: Text("Комментарии"),
        centerTitle: true,
        shadowColor: Colors.teal[900],
        backgroundColor: Colors.teal[900],
      ),
      resizeToAvoidBottomInset: false,
      body: Column(children: [
        Container(
            padding: EdgeInsets.all(10),
            height: getScreenHeight() * 0.2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(postList.title),
                Text(postList.body),
              ],
            )),
        Container(
            height: getScreenHeight() * 0.7,
            child: FutureBuilder<List<CommentsData>>(
              future: getComment(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<CommentsData>> snapshot) {
                Widget children;
                if (snapshot.hasData) {
                  children = ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          // height: 50,
                          child: Container(
                            padding: EdgeInsets.all(30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(snapshot.data![index].name),
                                Text(snapshot.data![index].email),
                                Text(snapshot.data![index].body),
                                SizedBox(
                                  height: 40,
                                )
                              ],
                            ),
                          ),
                        );
                      });
                } else if (snapshot.hasError) {
                  children = Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  );
                } else {
                  children = SizedBox(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(),
                  );
                }
                return children;
              },
            )),
        Container(
            height: getScreenHeight() * 0.1,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.teal[900]),
              ),
              child: Text('Hаписать комментарий'),
              onPressed: () {
                showPurchaseDialog(context);
              },
            ))
      ]),
    );
  }
}
