import 'package:shared_preferences/shared_preferences.dart';

Future<void> setPremium(bool isps) async {
  final prefs = await SharedPreferences.getInstance();

  await prefs.setBool('isps', isps);
}

Future<bool> isPremium() async {
  final prefs = await SharedPreferences.getInstance();

  return prefs.getBool('isps') ?? false;
}
