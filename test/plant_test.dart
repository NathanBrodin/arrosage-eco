import 'package:arrosage_eco/modele/plant.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Plant', () {
    test('default constructor should create a valid Plant object', () {
      final plant = Plant(
        id: 1,
        name: 'Test Plant',
        moistureMin: 0.2,
        moistureMax: 0.8,
        tempMinDay: 18.0,
        tempMaxDay: 28.0,
        tempMinNight: 12.0,
        tempMaxNight: 22.0,
        isCreated: true,
      );

      expect(plant.id, 1);
      expect(plant.name, 'Test Plant');
      expect(plant.moistureMin, 0.2);
      expect(plant.moistureMax, 0.8);
      expect(plant.tempMinDay, 18.0);
      expect(plant.tempMaxDay, 28.0);
      expect(plant.tempMinNight, 12.0);
      expect(plant.tempMaxNight, 22.0);
      expect(plant.isCreated, true);
    });

    test('defaultPlant constructor should create a default Plant object', () {
      final plant = Plant.defaultPlant();

      expect(plant.id, 0);
      expect(plant.name, 'Plant par défaut');
    });

    test('errorPlant constructor should create an error Plant object', () {
      final plant = Plant.errorPlant();

      expect(plant.id, -1);
      expect(plant.name, 'Erreur');
    });

    test('fromJson should create a valid Plant object from JSON', () {
      final json = {
        'id': 1,
        'name': 'Test Plant',
        'moisture_min': 0.2,
        'moisture_max': 0.8,
        'temp_min_day': 18.0,
        'temp_max_day': 28.0,
        'temp_min_night': 12.0,
        'temp_max_night': 22.0,
        'isCreated': true,
      };

      final plant = Plant.fromJson(json);

      expect(plant.id, 1);
      expect(plant.name, 'Test Plant');
    });

    test('toJson should create a valid JSON representation of a Plant object', () {
      final plant = Plant(
        id: 1,
        name: 'Test Plant',
        moistureMin: 0.2,
        moistureMax: 0.8,
        tempMinDay: 18.0,
        tempMaxDay: 28.0,
        tempMinNight: 12.0,
        tempMaxNight: 22.0,
        isCreated: true,
      );

      final json = plant.toJson();

      expect(json['id'], 1);
      expect(json['name'], 'Test Plant');
    });
  });
}
