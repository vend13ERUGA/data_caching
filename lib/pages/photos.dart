import 'package:data_caching/database/database.dart';
import 'package:data_caching/models/photo.dart';
import 'package:data_caching/services/user_photo.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Photos extends StatefulWidget {
  int IdUser;
  int IdAlbum;
  Photos(this.IdUser, this.IdAlbum);

  @override
  _PhotosState createState() => _PhotosState(IdUser, IdAlbum);
}

class _PhotosState extends State<Photos> {
  int IdUser;
  int IdAlbum;
  _PhotosState(this.IdUser, this.IdAlbum);
  List<PhotosData> photosList = [];
  Future<List<PhotosData>> getPhoto() async {
    var AllphotosList = await DatabaseClass.instance.readAllPhoto();
    for (var item in AllphotosList) {
      if (item.idUsers == IdUser && item.idAlbum == IdAlbum) {
        photosList.add(item);
      }
    }
    if (photosList.length == 1) {
      var photo = await loadJSONPhoto(IdAlbum, 1, 100000, IdUser);
      photo.removeAt(0);
      for (var item in photo) {
        await DatabaseClass.instance.createPhoto(item);
      }
      photosList.addAll(photo);
    } else if (photosList.length == 0) {
      var photo = await loadJSONPhoto(IdAlbum, 1, 100000, IdUser);
      for (var item in photo) {
        await DatabaseClass.instance.createPhoto(item);
      }
      photosList.addAll(photo);
    }
    return photosList;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List<PhotosData>>(
        future: getPhoto(),
        builder:
            (BuildContext context, AsyncSnapshot<List<PhotosData>> snapshot) {
          Widget children;
          if (snapshot.hasData) {
            children = CarouselSlider(
              options: CarouselOptions(height: 400.0),
              items: snapshot.data!.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        child: Column(
                          children: [
                            Container(
                              height: 70,
                              child: Text(
                                i.title,
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ),
                            Image.network(i.url),
                          ],
                        ));
                  },
                );
              }).toList(),
            );
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
          return Center(
            child: children,
          );
        },
      ),
    );
  }
}
