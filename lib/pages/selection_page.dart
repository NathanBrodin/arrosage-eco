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

  @override
  void initState() {
    super.initState();
    plantsFuture = _loadPlants(widget.id);
  }

Future<List<Plant>> _loadPlants(int specificId) async {
  final data = Data();
  List<Plant> plants = await data.loadPlantsFromJson();

  final plantIndex = plants.indexWhere((plant) => plant.id == specificId);
  if (plantIndex != -1) {
    final plant = plants.removeAt(plantIndex);
    plants.insert(0, plant);
  }

  return plants;
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
                  Plant plant = plants[index];
                  return Column(
                    children: [
                      const SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        padding: const EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
                          color: (index == 0) ? Theme.of(context).colorScheme.secondary : Theme.of(context).colorScheme.primary,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                                border: Border.all(
                                  width: 3.0,
                                  color:
                                      Theme.of(context).colorScheme.background,
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  plant.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                        color: Colors.white,
                                      ),
                                ),
                                Text(
                                  "${plant.tempMinDay}-${plant.tempMaxDay}° ${plant.moistureMin}-${plant.moistureMax}%",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: Colors.white,
                                      ),
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                // TODO: Envoyer les nouvelles donnees au systeme
                                Navigator.pop(context);
                              },
                              child: Container(
                                width: 60,
                                height: 60,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: Icon(
                                  Icons.arrow_forward_rounded,
                                  size: 40,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }),
              );
            }
          },
        ),
      ),
    );
  }
}
