import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  Future<void> setIsFirstTime(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstTime', value);
  }

  Future<bool> getIsFirstTime() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isFirstTime') ?? true; // Default to true if not set
  }
}
