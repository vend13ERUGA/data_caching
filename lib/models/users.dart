final String tableUsers = 'users';

class usersFields {
  static final List<String> values = [id, idUsers, name, username];

  static final String id = '_id';
  static final String idUsers = 'idUsers';
  static final String name = 'name';
  static final String username = 'username';
}

class UsersData {
  final int? id;
  final int idUsers;
  final String name;
  final String username;

  UsersData(
      {this.id,
      required this.idUsers,
      required this.name,
      required this.username});

  UsersData copy({int? id, int? idUsers, String? name, String? username}) =>
      UsersData(
          id: id ?? this.id,
          idUsers: idUsers ?? this.idUsers,
          name: name ?? this.name,
          username: username ?? this.username);

  static UsersData fromJson(Map<String, Object?> json) => UsersData(
      id: json[usersFields.id] as int?,
      idUsers: json[usersFields.idUsers] as int,
      name: json[usersFields.name] as String,
      username: json[usersFields.username] as String);

  Map<String, Object?> toJson() => {
        usersFields.id: id,
        usersFields.idUsers: idUsers,
        usersFields.name: name,
        usersFields.username: username
      };
}
