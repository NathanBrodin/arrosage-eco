import 'dart:async';
import 'dart:convert';
import 'package:arrosage_eco/modele/infos.dart';
import 'package:arrosage_eco/modele/plant.dart';
import 'package:flutter/services.dart';

class Data {
  late List<Plant> plants;
  late Infos infos;
  late Plant currentPlant;

  Data() {
    init();
  }

  Future<void> init() async {
    plants = await loadPlantsFromJson();
    infos = await getFromDevice();
    currentPlant = await getCurrentPlant();
  }

  static Future<Infos> getFromDevice() async {
    // Simulate the delay
    await Future.delayed(
      const Duration(
        seconds: 1,
      ),
    );

    return Infos(
        battery: 90,
        moisture: 32,
        sun: 34,
        temperature: 23,
        water: 67,
        currentPlantId: 0);
  }

  void setToDevice() {}

  static Future<List<Plant>> loadPlantsFromJson() async {
    String jsonString = await rootBundle.loadString('assets/plants.json');
    List<dynamic> jsonList = jsonDecode(jsonString);

    List<Plant> plants = jsonList.map((json) => Plant.fromJson(json)).toList();

    return plants;
  }

  Future<Plant> getCurrentPlant() async {
    List<Plant> loadedPlants = plants;
    Infos deviceInfos = infos;
    int currentPlantId = deviceInfos.currentPlantId;

    // Find the plant with the matching id
    Plant? currentPlant = loadedPlants.firstWhere(
      (plant) => plant.id == currentPlantId,
      orElse: () => Plant(
          id: 100,
          name: "Erreur",
          moistureMin: 0,
          moistureMax: 0,
          tempMinDay: 0,
          tempMaxDay: 0,
          tempMinNight: 0,
          tempMaxNight: 0,
          isCreated: true),
    );

    if (currentPlant.name == "Erreur") {
      throw Exception('No plant found with the current plant id');
    }

    return currentPlant;
  }
}
