import 'package:arrosage_eco/components/add_new.dart';
import 'package:arrosage_eco/components/plant_item.dart';
import 'package:flutter/material.dart';
import 'package:arrosage_eco/components/header.dart';
import 'package:arrosage_eco/modele/data.dart';
import 'package:arrosage_eco/modele/plant.dart';

class SelectionPage extends StatefulWidget {
  const SelectionPage(
      {Key? key, required this.title, required this.subtitle, required this.id})
      : super(key: key);
  final String title;
  final String subtitle;
  final int id;

  @override
  _SelectionPageState createState() => _SelectionPageState();
}

class _SelectionPageState extends State<SelectionPage> {
  late Future<List<Plant>> plantsFuture;
  late List<Plant> plants;
  late int maxId;

  @override
  void initState() {
    super.initState();
    plantsFuture = _loadPlants(widget.id);
  }

  Future<List<Plant>> _loadPlants(int specificId) async {
    final data = Data();
    plants = await data.loadPlantsFromJson();
    
    maxId = _getMaxId(plants);

    final plantIndex = plants.indexWhere((plant) => plant.id == specificId);
    if (plantIndex != -1) {
      final plant = plants.removeAt(plantIndex);
      plants.insert(0, plant);
    }
    return plants;
  }

  int _getMaxId(List<Plant> plants) {
    if (plants.isEmpty) {
      return 0;
    }
    List<Plant> sortedPlants =
        List.from(plants); // create a copy of the original list
    sortedPlants.sort((a, b) => b.id.compareTo(a.id));
    return sortedPlants.first.id;
  }

  void updatePlants(Plant newPlant) {
    setState(() {
      plants.insert(0, newPlant);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: Header(title: widget.title, subtitle: widget.subtitle),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FutureBuilder<List<Plant>>(
          future: plantsFuture,
          builder: (BuildContext context, AsyncSnapshot<List<Plant>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Erreur lors du chargement.'),
              );
            } else {
              final plants = snapshot.data!;
              return ListView.builder(
                itemCount: plants.length,
                itemBuilder: ((context, index) {
                  return PlantItem(
                    index: index,
                    plant: plants[index],
                  );
                }),
              );
            }
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: InkWell(
        onTap: () {
          showModalBottomSheet(
            backgroundColor: Colors.transparent,
            context: context,
            builder: (BuildContext context) {
              return AddNew(
                updatePlants: updatePlants,
                maxId: maxId + 1,
              );
            },
          );
        },
        child: Container(
          width: 60,
          height: 60,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: Icon(
            Icons.add_rounded,
            size: 40,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
