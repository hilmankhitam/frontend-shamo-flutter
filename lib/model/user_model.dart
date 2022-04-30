part of 'models.dart';

class UserModel {
  int? id;
  String? name;
  String? email;
  String? username;
  String? profilePictureUrl;
  String? token;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.username,
    this.profilePictureUrl,
    this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        username: json['username'],
        profilePictureUrl: json['profile_photo_url'],
        token: json['token'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'username': username,
        'profile_photo_url': profilePictureUrl,
        'token': token,
      };
}
