import 'package:arrosage_eco/components/add_new.dart';
import 'package:arrosage_eco/components/plant_item.dart';
import 'package:arrosage_eco/pages/base_page.dart';
import 'package:flutter/material.dart';
import 'package:arrosage_eco/components/header.dart';
import 'package:arrosage_eco/modele/plant.dart';

class SelectionPage extends StatefulWidget {
  const SelectionPage({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.id,
    required this.plants,
    required this.updateCurrentPlant,
    required this.update,
  }) : super(key: key);
  final String title;
  final String subtitle;
  final int id;
  final List<Plant> plants;
  final Function(Plant) updateCurrentPlant;
  final Function(Plant, String) update;

  @override
  _SelectionPageState createState() => _SelectionPageState();
}

class _SelectionPageState extends State<SelectionPage> {
  late List<Plant> plants;
  late int maxId;

  @override
  void initState() {
    super.initState();
    plants = widget.plants;
    maxId = _getMaxId(plants);

    final plantIndex = plants.indexWhere((plant) => plant.id == widget.id);
    if (plantIndex != -1) {
      final plant = plants.removeAt(plantIndex);
      plants.insert(0, plant);
    }
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
      widget.update(newPlant, "add");
    });
  }

  void removeCurrentPlant(Plant removedPlant) {
    setState(() {
      plants.removeWhere((plant) => plant.id == removedPlant.id);
      widget.update(removedPlant, "remove");
    });
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      header: Header(title: widget.title, subtitle: widget.subtitle),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 20),
        child: ListView.builder(
          itemCount: plants.length,
          itemBuilder: ((context, index) {
            return PlantItem(
              index: index,
              plant: plants[index],
              updateCurrentPlant: widget.updateCurrentPlant,
              removeCurrentPlant: removeCurrentPlant,
            );
          }),
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
