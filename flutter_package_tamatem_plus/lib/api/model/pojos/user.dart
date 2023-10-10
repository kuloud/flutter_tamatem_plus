class User {
  String? avatar;
  String? country;
  String? dateOfBirth;
  String? firstName;
  Map<String, dynamic>? gameSavedData;
  String? gender;
  int id;
  String? lastName;
  String? qrCode;
  String? signUpThrough;
  String tamatemId;

  User({
    required this.avatar,
    required this.country,
    required this.dateOfBirth,
    required this.firstName,
    required this.gameSavedData,
    required this.gender,
    required this.id,
    required this.lastName,
    required this.qrCode,
    required this.signUpThrough,
    required this.tamatemId,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        avatar: json["avatar"],
        country: json["country"],
        dateOfBirth: json["date_of_birth"],
        firstName: json["first_name"],
        gameSavedData: json["game_saved_data"],
        gender: json["gender"],
        id: json["id"],
        lastName: json["last_name"],
        qrCode: json["qr_code"],
        signUpThrough: json["sign_up_through"],
        tamatemId: json["tamatem_id"],
      );

  Map<String, dynamic> toJson() => {
        "avatar": avatar,
        "country": country,
        "date_of_birth": dateOfBirth,
        "first_name": firstName,
        "game_saved_data": gameSavedData,
        "gender": gender,
        "id": id,
        "last_name": lastName,
        "qr_code": qrCode,
        "sign_up_through": signUpThrough,
        "tamatem_id": tamatemId,
      };
}
