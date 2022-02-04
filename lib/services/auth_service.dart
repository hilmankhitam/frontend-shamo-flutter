part of 'services.dart';

class AuthService {
  //String baseUrl = 'http://192.168.1.9:8000/api';
  String baseUrl = 'https://shamo-backend.buildwithangga.id/api';

  Future<UserModel> register(
    String name,
    String username,
    String email,
    String password,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = '$baseUrl/register';
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      'name': name,
      'username': username,
      'email': email,
      'password': password
    });

    var response =
        await http.post(Uri.parse(url), headers: headers, body: body);
    debugPrint(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['user']);
      user.token = 'Bearer ' + data['access_token'];
      prefs.setString("user", user.token!);

      return user;
    } else {
      throw Exception('Gagal Register');
    }
  }

  Future<UserModel> login(
    String email,
    String password,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = '$baseUrl/login';
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({'email': email, 'password': password});

    var response =
        await http.post(Uri.parse(url), headers: headers, body: body);
    debugPrint(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['user']);
      user.token = 'Bearer ' + data['access_token'];
      prefs.setString("user", user.token!);

      return user;
    } else {
      throw Exception('Gagal Login');
    }
  }

  Future<UserModel> getUser(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = '$baseUrl/user';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    var response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    debugPrint(response.body);

    if (response.statusCode == 200) {
      UserModel user = jsonDecode(response.body)['data'];
      user.token = token;
      prefs.setString("user", user.token!);

      return user;
    } else {
      throw Exception('Gagal mengambil data user!');
    }
  }
}
