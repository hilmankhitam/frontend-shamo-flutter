part of 'providers.dart';

enum Status {
  notLoggedIn,
  notRegistered,
  loggedIn,
  registered,
  authenticating,
  registering,
  loggedOut
}

class AuthProvider with ChangeNotifier {
  UserModel? _user;

  UserModel get user => _user!;

  set user(UserModel user) {
    _user = user;
    notifyListeners();
  }

  void setUser(UserModel user) {
    _user = user;
  }

  Status _loggedInStatus = Status.notLoggedIn;
  Status _registeredInStatus = Status.notRegistered;

  Status get loggedInStatus => _loggedInStatus;
  set loggedInStatus(Status value) {
    _loggedInStatus = value;
    notifyListeners();
  }

  Status get registeredInStatus => _registeredInStatus;
  set registeredInStatus(Status value) {
    _registeredInStatus = value;
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

      UserPreferences().saveUser(user);
      _user = user;

      _loggedInStatus = Status.loggedIn;
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('error: $e');
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
      UserPreferences().saveUser(user);
      _user = user;

      _loggedInStatus = Status.loggedIn;
      notifyListeners();

      return true;
    } catch (e) {
      _loggedInStatus = Status.notLoggedIn;
      notifyListeners();
      debugPrint('error: $e');
      return false;
    }
  }
}
