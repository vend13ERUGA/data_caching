import 'package:data_caching/database/database.dart';
import 'package:data_caching/models/album.dart';
import 'package:data_caching/models/photo.dart';
import 'package:data_caching/pages/photos.dart';
import 'package:data_caching/services/user_photo.dart';
import 'package:data_caching/services/users_albums.dart';

import 'package:flutter/material.dart';

class AlbumFromUser extends StatefulWidget {
  int ID;
  AlbumFromUser(this.ID);

  @override
  _AlbumFromUserState createState() => _AlbumFromUserState(ID);
}

class _AlbumFromUserState extends State<AlbumFromUser> {
  bool activePage = true;
  List<AlbumsData> albumList = [];
  List<PhotosData> photosList = [];
  int ID;
  _AlbumFromUserState(this.ID);
  late ScrollController _controller;
  int lengthInMoment = 0;

  double getScreenHeight() {
    var padding = MediaQuery.of(context).padding;
    double height =
        MediaQuery.of(context).size.height - padding.top - kToolbarHeight;
    return height;
  }

  void getAlbumFromLateDisplay() async {
    for (var i = lengthInMoment; i <= lengthInMoment + 3; i++) {
      var post = await loadJSONAlbum(ID, i, 1);
      if (post.isNotEmpty) {
        albumList.add(post[0]);
        await DatabaseClass.instance.createAlbum(post[0]);
        var photo = await loadJSONPhoto(i, 1, 1, ID);
        await DatabaseClass.instance.createPhoto(photo[0]);
        photosList.add(photo[0]);
      }
    }
    if (lengthInMoment != albumList.length + 1 && activePage) {
      setState(() {});
    }
    lengthInMoment = albumList.length + 1;
  }

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      getAlbumFromLateDisplay();
    }
  }

  void getAlbumList() async {
    var AllphotosList = await DatabaseClass.instance.readAllPhoto();
    for (var item in AllphotosList) {
      if (item.idUsers == ID) {
        photosList.add(item);
      }
    }
    var AllAlbumsList = await DatabaseClass.instance.readAllAlbums();
    for (var item in AllAlbumsList) {
      if (item.idUsers == ID) {
        albumList.add(item);
      }
    }
    if (albumList.length == 3) {
      for (var i = 4; i < 6; i++) {
        var album = await loadJSONAlbum(ID, i, 1);
        albumList.add(album[0]);
        await DatabaseClass.instance.createAlbum(album[0]);
        var photo = await loadJSONPhoto(i, 1, 1, ID);
        await DatabaseClass.instance.createPhoto(photo[0]);
        photosList.add(photo[0]);
      }
    }
    setState(() {});
    lengthInMoment = albumList.length + 1;
  }

  @override
  void initState() {
    getAlbumList();
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
          title: Text("Все альбомы"),
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
            itemCount: albumList.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(albumList[index].title),
                    SizedBox(
                      height: 10,
                    ),
                    Image.network(
                      photosList[index].thumbnailUrl,
                      height: 90,
                      width: 90,
                    )
                  ],
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Photos(ID, albumList[index].idAlbum))).then((_) {
                    setState(() {});
                  });
                },
              );
            }));
  }
}
