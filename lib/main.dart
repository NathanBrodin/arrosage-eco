import 'package:arrosage_eco/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Arrosage éco',
      theme: ThemeData(
        fontFamily: 'Lato Regular',
        colorScheme: const ColorScheme(
            brightness: Brightness.light,
            primary: Color(0xFF1B4139),
            onPrimary: Color(0xFFA3D9D2),
            secondary: Color(0xFFFBB242),
            onSecondary: Color(0xFFFFCC4D),
            error: Colors.white,
            onError: Colors.white,
            background: Color(0xFFEEEBE5),
            onBackground: Colors.white,
            surface: Colors.white,
            onSurface: Colors.white),
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontSize: 26.0, fontFamily: 'Lato Black', color: Color(0xFF1B4139)),
          bodyMedium: TextStyle(fontSize: 16.0, fontFamily: 'Lato Regular', color: Color(0xFF1B4139),),
        ),
      ),
      home: const HomePage(
        title: 'Bienvenue !',
        subtitle: "Votre système d'arrosage est au point",
      ),
    );
  }
}