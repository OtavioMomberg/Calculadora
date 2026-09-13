import 'package:material_ui/material_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppThemes {
  late SharedPreferencesWithCache prefs;
  bool isDarkTheme = true;

  static final _instance = AppThemes._();
  factory AppThemes.instance() => _instance;
  new _();

  Future<void> loadTheme() async {
    prefs = await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(
        allowList: <String>{"isDarkTheme"}
      )
    );
    isDarkTheme = prefs.getBool("isDarkTheme") ?? true;
  }

  Future<void> changeTheme() async {
    isDarkTheme = !isDarkTheme;
    await prefs.setBool("isDarkTheme", isDarkTheme);
  }

  Color get color1 => isDarkTheme 
    ? const Color.fromARGB(255, 26, 33, 36) 
    : const Color.fromARGB(255, 173, 205, 219);

  Color get color2 => isDarkTheme 
    ? const Color.fromARGB(255, 22, 30, 33) 
    : const Color.fromARGB(255, 168, 194, 205);

  Color get color3 => isDarkTheme 
    ? const Color.fromARGB(161, 209, 209, 209) 
    : const Color.fromARGB(255, 97, 119, 129);

  Color get color4 => isDarkTheme 
    ? const Color.fromARGB(159, 120, 201, 227) 
    : const Color.fromARGB(255, 22, 111, 163);

  Color get color5 => isDarkTheme 
    ? const Color.fromARGB(255, 47, 67, 75) 
    : const Color.fromARGB(255, 107, 127, 136);

  Color get color6 => isDarkTheme 
    ? const Color.fromARGB(255, 22, 31, 35) 
    : const Color.fromARGB(255, 122, 152, 164);

  static const darkGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color.fromARGB(255, 26, 33, 36),
      Color.fromARGB(255, 22, 31, 35)
    ]
  ); 

  static const lightGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color.fromARGB(255, 173, 205, 219),
      Color.fromARGB(255, 122, 152, 164)
    ]
  ); 


}
