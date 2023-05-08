import 'dart:async';
import 'dart:convert';
import 'package:arrosage_eco/modele/infos.dart';
import 'package:arrosage_eco/modele/plant.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Data {
  late List<Plant> plants;
  late Infos infos;
  late Plant currentPlant;

  Data() {
    init();
  }

  Future<void> init() async {
    plants = await loadPlants();
    infos = await getFromDevice();
    currentPlant = await getCurrentPlant();
  }

  static Future<Infos> getFromDevice() async {
    // Simule le chargement dû à l'envoie de donnée depuis le systeme
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

  static Future<List<Plant>> loadPlantsFromJson() async {
    String jsonString = await rootBundle.loadString('assets/plants.json');
    List<dynamic> jsonList = jsonDecode(jsonString);

    List<Plant> plants = jsonList.map((json) => Plant.fromJson(json)).toList();

    return plants;
  }

  Future<void> savePlants() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String plantsJson =
        jsonEncode(plants.map((plant) => plant.toJson()).toList());
    await prefs.setString('plants', plantsJson);
  }

  Future<List<Plant>> loadPlants() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? plantsJson = prefs.getString('plants');
    List<Plant> plantsFromJson = await loadPlantsFromJson();

    if (plantsJson != null) {
      List<dynamic> jsonList = jsonDecode(plantsJson);
      List<Plant> plantsFromPrefs =
          jsonList.map((json) => Plant.fromJson(json)).toList();
      plantsFromJson.addAll(plantsFromPrefs
          .where((p) => !plantsFromJson.any((e) => e.id == p.id)));
    }

    return plantsFromJson;
  }

  void updatePlants(Plant plant, String action) {
    if(action == "add") {
      addPlant(plant);
    }
    if(action == "remove") {
      removePlant(plant);
    }
  }

  void addPlant(Plant plant) {
    plants.add(plant);
    savePlants();
  }

  void removePlant(Plant plant) {
    plants.remove(plant);
    savePlants();
  }

  Future<Plant> getCurrentPlant() async {
    List<Plant> loadedPlants = plants;
    Infos deviceInfos = infos;
    int currentPlantId = deviceInfos.currentPlantId;

    // Find the plant with the matching id
    Plant? currentPlant = loadedPlants.firstWhere(
        (plant) => plant.id == currentPlantId,
        orElse: () => Plant.errorPlant());

    if (currentPlant.name == "Erreur") {
      throw Exception('No plant found with the current plant id');
    }

    return currentPlant;
  }
}
