import 'package:arrosage_eco/modele/infos.dart';
import 'package:arrosage_eco/modele/plant.dart';
import 'package:arrosage_eco/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    Infos infos =
        Infos(battery: 90, moisture: 32, sun: 50, temperature: 23, water: 67);

    Map<String, dynamic> plantJson = {
      "id": 2,
      "name": "Salades",
      "moisture_min": 10.0,
      "moisture_max": 30.0,
      "temp_min_day": 18.0,
      "temp_max_day": 32.0,
      "temp_min_night": 10.0,
      "temp_max_night": 13.0
    };

    Plant currentPlant = Plant.fromJson(plantJson);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
          titleLarge: TextStyle(
              fontSize: 26.0,
              fontFamily: 'Lato Black',
              color: Color(0xFF1B4139)),
          bodyMedium: TextStyle(
            fontSize: 16.0,
            fontFamily: 'Lato Regular',
            color: Color(0xFF1B4139),
          ),
        ),
      ),
      home: HomePage(
        infos: infos,
        currentPlant: currentPlant,
        title: 'Bienvenue !',
        subtitle: "Votre système d'arrosage est au point",
      ),
    );
  }
}
