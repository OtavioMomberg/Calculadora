import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modern_calculator/themes/app_themes.dart';
import 'pages/calculator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await AppThemes.instance().loadTheme();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Electrolize',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 26, 33, 36),
        ),
      ),
      home: const Calculator(),
    );
  }
}
