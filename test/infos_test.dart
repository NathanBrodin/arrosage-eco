import 'package:arrosage_eco/modele/infos.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Infos', () {
    test('constructor should create a valid Infos object', () {
      final infos = Infos(
        battery: 80,
        moisture: 50,
        sun: 70,
        temperature: 22,
        water: 90,
        currentPlantId: 1,
      );

      expect(infos.battery, 80);
      expect(infos.moisture, 50);
      expect(infos.sun, 70);
      expect(infos.temperature, 22);
      expect(infos.water, 90);
      expect(infos.currentPlantId, 1);
    });
  });
}
