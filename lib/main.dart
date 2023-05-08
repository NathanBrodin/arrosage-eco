import 'package:arrosage_eco/modele/data.dart';
import 'package:arrosage_eco/pages/home_page.dart';
import 'package:arrosage_eco/pages/home_page_skeleton.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final Future<Data> dataFuture;

  _MyAppState() {
    dataFuture = _initData();
  }

  Future<Data> _initData() async {
    Data data = Data();
    await data.init();
    return data;
  }

  @override
  Widget build(BuildContext context) {
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
            color: Color(0xFF1B4139),
          ),
          bodyMedium: TextStyle(
            fontSize: 16.0,
            fontFamily: 'Lato Regular',
            color: Color(0xFF1B4139),
          ),
        ),
      ),
      home: FutureBuilder<Data>(
        future: dataFuture,
        builder: (BuildContext context, AsyncSnapshot<Data> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error: ${snapshot.error}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              );
            }

            Data data = snapshot.data!;
            return HomePage(
              infos: data.infos,
              plants: data.plants,
              currentPlant: data.currentPlant,
              update: data.updatePlants,
              title: 'Bienvenue !',
              subtitle: "Votre système d'arrosage est au point",
            );
          } else {
            return const HomePageSkeleton(title: "Chargement !", subtitle: "Vos données arrivent d'ici peu");
          }
        },
      ),
    );
  }
}
