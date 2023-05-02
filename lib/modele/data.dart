import 'dart:convert';

import 'package:arrosage_eco/modele/plant.dart';
import 'package:flutter/services.dart';

class Data {
  void getFromDevice() {}

  void setToDevice() {}

  Future<List<Plant>> loadPlantsFromJson() async {
    String jsonString = await rootBundle.loadString('assets/plants.json');
    List<dynamic> jsonList = jsonDecode(jsonString);

    List<Plant> plants = jsonList.map((json) => Plant.fromJson(json)).toList();

    return plants;
  }
}
