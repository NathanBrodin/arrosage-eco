import 'package:flutter_test/flutter_test.dart';
import 'package:arrosage_eco/modele/plant.dart';
import 'package:arrosage_eco/modele/data.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Data data;
  late MockSharedPreferences mockPrefs;

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    mockPrefs = MockSharedPreferences();
    data = Data(prefs: mockPrefs);
  });

  group('Data class', () {
    test('init should initialize plants and infos', () async {
      await data.init();
      expect(data.plants, isNotEmpty);
      expect(data.infos, isNotNull);
    });

    test('loadPlants should load plants from SharedPreferences', () async {
      await data.init();
      await data.savePlants();
      List<Plant> loadedPlants = await data.loadPlants();
      expect(loadedPlants, isNotEmpty);
    });
  });
}
