import 'package:data_caching/models/album.dart';
import 'package:data_caching/models/photo.dart';
import 'package:data_caching/models/post.dart';
import 'package:data_caching/pages/albums_from_user.dart';
import 'package:data_caching/pages/posts_from_user.dart';
import 'package:data_caching/services/user_photo.dart';
import 'package:data_caching/services/users_albums.dart';
import 'package:data_caching/services/users_posts.dart';
import 'package:flutter/material.dart';
import 'package:data_caching/models/user_details.dart';
import 'package:data_caching/services/user_details_parser.dart';
import 'package:data_caching/database/database.dart';

class UserDetails extends StatefulWidget {
  int ID;
  String name;
  String username;
  UserDetails(this.ID, this.name, this.username);

  @override
  _UserDetailsState createState() => _UserDetailsState(ID, name, username);
}

class _UserDetailsState extends State<UserDetails> {
  @override
  int ID;
  String name;
  String username;
  _UserDetailsState(this.ID, this.name, this.username);

  Future<UserDetailData?> getUsers() async {
    UserDetailData? userDetails;
    var userDetailsList = await DatabaseClass.instance.readAllDetails();
    var presence =
        userDetailsList.any((element) => element.idUserDetails == ID);
    if (presence) {
      for (var item in userDetailsList) {
        if (item.idUserDetails == ID) {
          return item;
        }
      }
    } else {
      userDetails = await loadJSON(ID);
      await DatabaseClass.instance.createDetails(userDetails);
      return userDetails;
    }
  }

  Future<List<PostsData>> getPost() async {
    List<PostsData> postList = await DatabaseClass.instance.readAllPosts();
    var presence = postList.any((element) => element.idUsers == ID);
    if (!presence) {
      var post = await loadJSONPost(ID, 1, 3);
      for (var item in post) {
        await DatabaseClass.instance.createPost(item);
        postList.add(item);
      }
    }
    List<PostsData> postListInId = [];
    for (var item in postList) {
      if (item.idUsers == ID) {
        postListInId.add(item);
      }
    }

    return postListInId;
  }

  Future<List<dynamic>> getAlbum() async {
    List<AlbumsData> albumList = await DatabaseClass.instance.readAllAlbums();
    var presence = albumList.any((element) => element.idUsers == ID);
    if (!presence) {
      var album = await loadJSONAlbum(ID, 1, 3);
      for (var item in album) {
        await DatabaseClass.instance.createAlbum(item);
        albumList.add(item);
      }
    }
    List<AlbumsData> albumListInId = [];
    for (var item in albumList) {
      if (item.idUsers == ID) {
        albumListInId.add(item);
      }
    }

    List<PhotosData> photosList = await DatabaseClass.instance.readAllPhoto();
    var presencePhoto = photosList.any((element) => element.idUsers == ID);
    if (!presencePhoto) {
      var photo = await loadJSONPhoto(albumListInId[0].idAlbum, 1, 1, ID);
      await DatabaseClass.instance.createPhoto(photo[0]);
      photosList.add(photo[0]);
      photo = await loadJSONPhoto(albumListInId[1].idAlbum, 1, 1, ID);
      await DatabaseClass.instance.createPhoto(photo[0]);
      photosList.add(photo[0]);
      photo = await loadJSONPhoto(albumListInId[2].idAlbum, 1, 1, ID);
      await DatabaseClass.instance.createPhoto(photo[0]);
      photosList.add(photo[0]);
    }
    List<PhotosData> photoListInId = [];
    for (var item in photosList) {
      if (item.idUsers == ID) {
        photoListInId.add(item);
      }
    }
    List<dynamic> snapshots = [albumListInId, photoListInId];

    return snapshots;
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
          title: Text(name),
          centerTitle: true,
          shadowColor: Colors.teal[900],
          backgroundColor: Colors.teal[900],
        ),
        body: SingleChildScrollView(
          child: Container(
              // color: Colors.white,
              child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                color: Colors.white,
                height: 400,
                child: FutureBuilder<UserDetailData?>(
                  future: getUsers(),
                  builder: (BuildContext context,
                      AsyncSnapshot<UserDetailData?> snapshot) {
                    Widget children;
                    if (snapshot.hasData) {
                      children = Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 40,
                          ),
                          Text("Имя: " + name),
                          Text("Логин: " + username),
                          Text("Почта: " + snapshot.data!.email),
                          SizedBox(
                            height: 20,
                          ),
                          Text("Адресс:"),
                          Text("Улица: " + snapshot.data!.street),
                          Text("Квартира: " + snapshot.data!.suite),
                          Text("Город: " + snapshot.data!.city),
                          Text("Индекс: " + snapshot.data!.zipcode),
                          SizedBox(
                            height: 20,
                          ),
                          Text("Координаты: "),
                          Text("lat: " + snapshot.data!.lat),
                          Text("lng: " + snapshot.data!.lng),
                          Text("Телефон: " + snapshot.data!.phone),
                          Text("Сайт: " + snapshot.data!.website),
                          SizedBox(
                            height: 20,
                          ),
                          Text("Работа: " + snapshot.data!.companyName),
                          Text("BS: " + snapshot.data!.companyBs),
                          Text("Cтатус: " + snapshot.data!.companyCatchPhrase),
                        ],
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
              Container(
                height: 350,
                child: FutureBuilder<List<PostsData>>(
                  future: getPost(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<PostsData>> snapshot) {
                    Widget children;
                    if (snapshot.hasData) {
                      children = Container(
                          color: Colors.white,
                          padding: EdgeInsets.only(
                              top: 40, bottom: 0, left: 40, right: 40),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Посты:"),
                              SizedBox(
                                height: 20,
                              ),
                              Text("Заголовок: " + snapshot.data![0].title),
                              Text("Cообщение: " +
                                  snapshot.data![0].body.split('\n')[0]),
                              SizedBox(height: 10),
                              Text("Заголовок: " + snapshot.data![1].title),
                              Text("Cообщение: " +
                                  snapshot.data![1].body.split('\n')[0]),
                              SizedBox(height: 10),
                              Text("Заголовок: " + snapshot.data![2].title),
                              Text("Cообщение: " +
                                  snapshot.data![2].body.split('\n')[0]),
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.teal[900]),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PostFromUser(ID))).then((_) {
                                    setState(() {});
                                  });
                                },
                                child: Text(
                                  "Посмотреть все",
                                ),
                              )
                            ],
                          ));
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
              Container(
                padding:
                    EdgeInsets.only(top: 0, bottom: 0, left: 40, right: 40),
                color: Colors.white,
                height: 850,
                child: FutureBuilder<List<dynamic>>(
                  future: getAlbum(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<dynamic>> snapshott) {
                    Widget children;
                    if (snapshott.hasData) {
                      children = Container(
                          color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: 0,
                              ),
                              Text("Альбомы:"),
                              Text("Заголовок: " +
                                  snapshott.data![0][0].title.toString()),
                              Image.network(snapshott.data![1][0].thumbnailUrl),
                              Text("Заголовок: " +
                                  snapshott.data![0][1].title.toString()),
                              Image.network(snapshott.data![1][1].thumbnailUrl),
                              Text("Заголовок: " +
                                  snapshott.data![0][2].title.toString()),
                              Image.network(snapshott.data![1][2].thumbnailUrl),
                              ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.teal[900]),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AlbumFromUser(ID))).then((_) {
                                      setState(() {});
                                    });
                                  },
                                  child: Text("Посмотреть все")),
                            ],
                          ));
                    } else if (snapshott.hasError) {
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
                    return children;
                  },
                ),
              )
            ],
          )),
        ));
  }
}
