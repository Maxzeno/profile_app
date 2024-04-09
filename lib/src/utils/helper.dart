import 'package:profile/main.dart';

const String tokenKey = 'token';
const String firstTimeKey = 'firstTime';

String? getToken() {
  return prefs.getString(tokenKey);
}

Future<bool> setToken(String token) async {
  return await prefs.setString(tokenKey, token);
}

Future<bool> removeToken() async {
  return await prefs.remove(tokenKey);
}

bool isFirstTime() {
  return prefs.getBool(firstTimeKey) ?? true;
}

Future<bool> setFirstTime() async {
  if (isFirstTime()) {
    return prefs.setBool(firstTimeKey, false);
  }
  return true;
}
