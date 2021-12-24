import 'package:data_caching/models/album.dart';
import 'package:data_caching/models/photo.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:data_caching/models/users.dart';
import 'package:data_caching/models/user_details.dart';
import 'package:data_caching/models/post.dart';
import 'package:data_caching/models/comments.dart';

class DatabaseClass {
  static final DatabaseClass instance = DatabaseClass._init();

  static Database? _database;

  DatabaseClass._init();

  Future<void> initDB() async {
    if (_database == null) {
      final dbPath = await getDatabasesPath();
      final path = join(dbPath, "database.db");
      _database = await openDatabase(path, version: 1, onCreate: _createDB);
    }
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final integerType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE $tableUsers ( 
  ${usersFields.id} $idType, 
  ${usersFields.idUsers} $integerType, 
  ${usersFields.name} $textType,
  ${usersFields.username} $textType
  )
''');

    await db.execute('''
CREATE TABLE $tableUserDetails ( 
  ${userDetailFields.id} $idType, 
  ${userDetailFields.idUserDetails} $integerType, 
  ${userDetailFields.email} $textType,
  ${userDetailFields.phone} $textType,
  ${userDetailFields.website} $textType,
  ${userDetailFields.companyName} $textType,
  ${userDetailFields.companyBs} $textType,
  ${userDetailFields.companyCatchPhrase} $textType,
  ${userDetailFields.street} $textType,
  ${userDetailFields.suite} $textType,
  ${userDetailFields.city} $textType,
  ${userDetailFields.lat} $textType,
  ${userDetailFields.lng} $textType,
  ${userDetailFields.zipcode} $textType
  )
''');
    await db.execute('''
CREATE TABLE $tablePosts ( 
  ${postFields.id} $idType, 
  ${postFields.idUsers} $integerType, 
  ${postFields.idPost} $integerType, 
  ${postFields.title} $textType,
  ${postFields.body} $textType
  )
''');

    await db.execute('''
CREATE TABLE $tableAlbum ( 
  ${albumFields.id} $idType, 
  ${albumFields.idUsers} $integerType, 
  ${albumFields.idAlbum} $integerType, 
  ${albumFields.title} $textType
  )
''');
    await db.execute('''
CREATE TABLE $tablePhoto ( 
  ${photoFields.id} $idType, 
  ${photoFields.idUsers} $integerType, 
  ${photoFields.idAlbum} $integerType, 
  ${photoFields.idPhoto} $integerType, 
  ${photoFields.title} $textType,
  ${photoFields.url} $textType,
  ${photoFields.thumbnailUrl} $textType
  )
''');

    await db.execute('''
CREATE TABLE $tableComment ( 
  ${commentFields.id} $idType, 
  ${commentFields.idPost} $integerType, 
  ${commentFields.idComment} $integerType,  
  ${commentFields.name} $textType,
  ${commentFields.email} $textType,
  ${commentFields.body} $textType
  )
''');
  }

  Future<UsersData> create(UsersData users) async {
    final id = await _database!.insert('users', users.toJson());
    return users.copy(id: id);
  }

  Future<UserDetailData> createDetails(UserDetailData usersDEtail) async {
    final id = await _database!.insert('userDetails', usersDEtail.toJson());
    return usersDEtail.copy(id: id);
  }

  Future<PostsData> createPost(PostsData post) async {
    final id = await _database!.insert('posts', post.toJson());
    return post.copy(id: id);
  }

  Future<AlbumsData> createAlbum(AlbumsData album) async {
    final id = await _database!.insert('album', album.toJson());
    return album.copy(id: id);
  }

  Future<PhotosData> createPhoto(PhotosData photo) async {
    final id = await _database!.insert('photo', photo.toJson());
    return photo.copy(id: id);
  }

  Future<CommentsData> createComment(CommentsData comment) async {
    final id = await _database!.insert('comment', comment.toJson());
    return comment.copy(id: id);
  }

  Future<List<UsersData>> readAll() async {
    final result = await _database!.query('users');
    return result.map((json) => UsersData.fromJson(json)).toList();
  }

  Future<List<CommentsData>> readAllComments() async {
    final result = await _database!.query('comment');
    return result.map((json) => CommentsData.fromJson(json)).toList();
  }

  Future<List<UserDetailData>> readAllDetails() async {
    final result = await _database!.query('userDetails');
    return result.map((json) => UserDetailData.fromJson(json)).toList();
  }

  Future<List<PostsData>> readAllPosts() async {
    final result = await _database!.query('posts');
    return result.map((json) => PostsData.fromJson(json)).toList();
  }

  Future<List<AlbumsData>> readAllAlbums() async {
    final result = await _database!.query('album');
    return result.map((json) => AlbumsData.fromJson(json)).toList();
  }

  Future<List<PhotosData>> readAllPhoto() async {
    final result = await _database!.query('photo');
    return result.map((json) => PhotosData.fromJson(json)).toList();
  }

  Future<int> update(UsersData databaseData) {
    return _database!.update(
      tableUsers,
      databaseData.toJson(),
      where: '${usersFields.id} = ?',
      whereArgs: [databaseData.id],
    );
  }

  Future deleteAll() async {
    await _database!.rawDelete("DELETE FROM $tableUsers");
  }

  void close() {
    _database!.close();
  }
}
