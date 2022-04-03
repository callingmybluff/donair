import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  final SharedPreferences prefs;

  LocalStorage._({required this.prefs});

  static Future<LocalStorage> create() async {
    return LocalStorage._(prefs: await SharedPreferences.getInstance());
  }

  setData(String data) => prefs.setString('data', data);

  getData() {
    if (prefs.containsKey('data')) {
      return prefs.getString('data');
    } else {
      return null;
    }
  }
}
