import 'package:profile/main.dart';

const String tokenKey = 'token';

String? getToken() {
  return prefs.getString(tokenKey);
}

Future<bool> setToken(String token) async {
  return await prefs.setString(tokenKey, token);
}

Future<bool> removeToken() async {
  return await prefs.remove(tokenKey);
}
