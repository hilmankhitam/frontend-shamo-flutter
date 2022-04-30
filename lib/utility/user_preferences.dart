import 'package:shamo/model/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static const idKey = "idKey";
  static const nameKey = "nameKey";
  static const emailKey = "emailKey";
  static const usernameKey = "usernameKey";
  static const profilePicKey = "profilePicKey";
  static const tokenKey = "tokenKey";

  Future<bool> saveUser(UserModel user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setInt(idKey, user.id!);
    prefs.setString(nameKey, user.name!);
    prefs.setString(emailKey, user.email!);
    prefs.setString(usernameKey, user.name!);
    prefs.setString(profilePicKey, user.profilePictureUrl!);
    prefs.setString(tokenKey, user.token!);

    return prefs.commit();
  }

  Future<UserModel> getUser() async {
    await Future.delayed(const Duration(seconds: 2));
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    int userId = prefs.getInt(idKey) ?? 0;
    String name = prefs.getString(nameKey) ?? "";
    String email = prefs.getString(emailKey) ?? "";
    String username = prefs.getString(usernameKey) ?? "";
    String profilePic = prefs.getString(profilePicKey) ?? "";
    String token = prefs.getString(tokenKey) ?? "";

    if (userId != 0) {
      UserModel user = UserModel(
        id: userId,
        name: name,
        email: email,
        username: username,
        profilePictureUrl: profilePic,
        token: token,
      );

      return user;
    } else {
      throw Exception('Data tidak ada');
    }
  }

  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove(idKey);
    prefs.remove(nameKey);
    prefs.remove(emailKey);
    prefs.remove(usernameKey);
    prefs.remove(profilePicKey);
    prefs.remove(tokenKey);
  }

  Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(tokenKey);
    return token!;
  }
}
