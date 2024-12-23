import 'package:recepies_app/models/user.dart';
import 'package:recepies_app/services/http_service.dart';

class AuthService {
  static final AuthService _singleton = AuthService._internal();

  final _httpService = HTTPService();

  User? user;

  factory AuthService() {
    return _singleton;
  }

  AuthService._internal();

  Future<bool> login(String username, String password) async {
    try {
      var response = await _httpService.post("auth/login", {
        "username": username,
        "password": password,
      });

      if (response?.statusCode == 200 && response?.data != null) {
        user = User.fromJson(response!.data);
        HTTPService().setup(bearerToken: user!.accessToken);
        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }
}
