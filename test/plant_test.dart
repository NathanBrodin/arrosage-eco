import 'package:arrosage_eco/modele/data.dart';
import 'package:arrosage_eco/modele/plant.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('loadPlantsFromJson() should load plants data correctly', () async {
    var data = Data();
    List<Plant> plants = await data.loadPlantsFromJson();

    // Check if the list is not empty
    expect(plants.isNotEmpty, true);

    // Check if the first plant has the correct data
    Plant firstPlant = plants.first;
    expect(firstPlant.id, 0);
    expect(firstPlant.name, 'Cactus');
    expect(firstPlant.moistureMin, 10.0);
    expect(firstPlant.moistureMax, 30.0);
    expect(firstPlant.tempMinDay, 18.0);
    expect(firstPlant.tempMaxDay, 32.0);
    expect(firstPlant.tempMinNight, 10.0);
    expect(firstPlant.tempMaxNight, 13.0);
  });
}
