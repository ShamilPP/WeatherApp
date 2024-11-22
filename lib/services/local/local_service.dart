import 'package:shared_preferences/shared_preferences.dart';

class LocalService {
  static Future<bool> saveUser(String id) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    bool result = await pref.setString('user', id);
    return result;
  }

  static Future<String?> getUser() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? docId = pref.getString('user');
    return docId;
  }

  static Future<bool> removeUser() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    bool result = await pref.remove('user');
    return result;
  }
}
