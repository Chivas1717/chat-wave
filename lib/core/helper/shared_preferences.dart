import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesRepository {
  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> writeString(
      {required SharedPreferencesKeys key, required String value}) async {
    await _prefs.setString(key.name, value);
  }

  String? readString({required SharedPreferencesKeys key}) {
    return _prefs.getString(key.name);
  }

  Future<bool?> removeString({required SharedPreferencesKeys key}) {
    return _prefs.remove(key.name);
  }

  Future<void> clear() async {
    await _prefs.clear();
  }
}

enum SharedPreferencesKeys {
  token,
  userId;
}
