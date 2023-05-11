import 'dart:async';
import 'dart:convert';
import 'package:arrosage_eco/modele/infos.dart';
import 'package:arrosage_eco/modele/plant.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Data {
  late List<Plant> plants;
  late Infos infos;
  late Plant currentPlant;
  SharedPreferences? prefs;
  String ipAddress = "";

  Data({this.prefs}) {
    init();
  }

  Future<void> init() async {
    plants = await loadPlants();
    infos = await getFromDevice();
    currentPlant = await getCurrentPlant();
  }

  Future<Infos> getFromDevice() async {
    final response =
        await http.get(Uri.parse('$ipAddress/data'));

    if (response.statusCode == 200) {
      final infos = json.decode(response.body);

      return Infos(
          battery: infos['battery'],
          moisture: infos['moisture'],
          sun: infos['sun'],
          temperature: infos['temperature'],
          water: infos['water'],
          currentPlantId: infos['currentPlantId']);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> sendToDevice(Plant newPlant) async {
    final response = await http.post(
      Uri.parse('$ipAddress/send-data'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(newPlant.toJson()),
    );

    if (response.statusCode == 200) {
      print('Data sent successfully');
    } else {
      throw Exception('Failed to send data');
    }
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
    if (action == "add") {
      addPlant(plant);
    }
    if (action == "remove") {
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
