final String tableUserDetails = 'userDetails';

class userDetailFields {
  static final List<String> values = [
    id,
    idUserDetails,
    email,
    phone,
    website,
    companyName,
    companyBs,
    companyCatchPhrase,
    street,
    suite,
    city,
    lat,
    lng,
    zipcode
  ];
  static final String id = '_id';
  static final String idUserDetails = 'idUserDetails';
  static final String email = 'email';
  static final String phone = 'phone';
  static final String website = 'website';
  static final String companyName = 'companyName';
  static final String companyBs = 'companyBs';
  static final String companyCatchPhrase = 'companyCatchPhrase';
  static final String street = 'street';
  static final String suite = 'suite';
  static final String city = 'city';
  static final String lat = 'lat';
  static final String lng = 'lng';
  static final String zipcode = 'zipcode';
}

class UserDetailData {
  final int? id;
  final int idUserDetails;
  final String email;
  final String phone;
  final String website;
  final String companyName;
  final String companyBs;
  final String companyCatchPhrase;
  final String street;
  final String suite;
  final String city;
  final String lat;
  final String lng;
  final String zipcode;

  UserDetailData(
      {this.id,
      required this.idUserDetails,
      required this.email,
      required this.phone,
      required this.website,
      required this.companyName,
      required this.companyBs,
      required this.companyCatchPhrase,
      required this.street,
      required this.suite,
      required this.city,
      required this.lat,
      required this.lng,
      required this.zipcode});

  UserDetailData copy(
          {int? id,
          int? idUserDetails,
          String? email,
          String? phone,
          String? website,
          String? companyName,
          String? companyBs,
          String? companyCatchPhrase,
          String? street,
          String? suite,
          String? city,
          String? lat,
          String? lng,
          String? zipcode}) =>
      UserDetailData(
          id: id ?? this.id,
          idUserDetails: idUserDetails ?? this.idUserDetails,
          email: email ?? this.email,
          phone: phone ?? this.phone,
          website: website ?? this.website,
          companyName: companyName ?? this.companyName,
          companyBs: companyBs ?? this.companyBs,
          companyCatchPhrase: companyCatchPhrase ?? this.companyCatchPhrase,
          street: street ?? this.street,
          suite: suite ?? this.suite,
          city: city ?? this.city,
          lat: lat ?? this.lat,
          lng: lng ?? this.lng,
          zipcode: zipcode ?? this.zipcode);

  static UserDetailData fromJson(Map<String, Object?> json) => UserDetailData(
      id: json[userDetailFields.id] as int?,
      idUserDetails: json[userDetailFields.idUserDetails] as int,
      email: json[userDetailFields.email] as String,
      phone: json[userDetailFields.phone] as String,
      website: json[userDetailFields.website] as String,
      companyName: json[userDetailFields.companyName] as String,
      companyBs: json[userDetailFields.companyBs] as String,
      companyCatchPhrase: json[userDetailFields.companyCatchPhrase] as String,
      street: json[userDetailFields.street] as String,
      suite: json[userDetailFields.suite] as String,
      city: json[userDetailFields.city] as String,
      lat: json[userDetailFields.lat] as String,
      lng: json[userDetailFields.lng] as String,
      zipcode: json[userDetailFields.zipcode] as String);

  Map<String, Object?> toJson() => {
        userDetailFields.id: id,
        userDetailFields.idUserDetails: idUserDetails,
        userDetailFields.email: email,
        userDetailFields.phone: phone,
        userDetailFields.website: website,
        userDetailFields.companyName: companyName,
        userDetailFields.companyBs: companyBs,
        userDetailFields.companyCatchPhrase: companyCatchPhrase,
        userDetailFields.street: street,
        userDetailFields.suite: suite,
        userDetailFields.city: city,
        userDetailFields.lat: lat,
        userDetailFields.lng: lng,
        userDetailFields.zipcode: zipcode
      };
}
