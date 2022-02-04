part of 'providers.dart';

class AuthProvider with ChangeNotifier {
  UserModel? _user;

  UserModel get user => _user!;

  set user(UserModel user) {
    _user = user;
    notifyListeners();
  }

  Future<bool> register(
    String name,
    String username,
    String email,
    String password,
  ) async {
    try {
      UserModel user = await AuthService().register(
        name,
        username,
        email,
        password,
      );

      _user = user;
      return true;
    } catch (e) {
      debugPrint('ERROR : $e');
      return false;
    }
  }

  Future<bool> login(
    String email,
    String password,
  ) async {
    try {
      UserModel user = await AuthService().login(
        email,
        password,
      );

      _user = user;
      return true;
    } catch (e) {
      debugPrint('ERROR : $e');
      return false;
    }
  }

  Future<void> getUser(String token) async {
    try {
      UserModel user = await AuthService().getUser(token);
      _user = user;
    } catch (e) {
      debugPrint('ERROR : $e');
    }
  }
}
