import 'package:arrosage_eco/components/my_snackbar.dart';
import 'package:arrosage_eco/modele/plant.dart';
import 'package:flutter/material.dart';

class PlantItem extends StatelessWidget {
  const PlantItem(
      {Key? key,
      required this.index,
      required this.plant,
      required this.updateCurrentPlant,
      required this.removeCurrentPlant})
      : super(key: key);
  final int index;
  final Plant plant;
  final Function(Plant) updateCurrentPlant;
  final Function(Plant) removeCurrentPlant;

  void _handleOnTap(BuildContext context) {
    updateCurrentPlant(plant);
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      MySnackbar(
        context: context,
        priority: "info",
        text: "La nouvelle plante à bien été prise en compte",
        icon: Icons
            .more_vert_rounded, // priority_high / warning / exclamation pour "error"
      ),
    );
  }

  void _removePlant(BuildContext context) {
    if (plant.isCreated == false) {
      return;
    }

    removeCurrentPlant(plant);
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      MySnackbar(
        context: context,
        priority: "info",
        text: "La plante à bien été supprimé",
        icon: Icons
            .more_vert_rounded, // priority_high / warning / exclamation pour "error"
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
            color: (index == 0)
                ? Theme.of(context).colorScheme.secondary
                : Theme.of(context).colorScheme.primary,
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
                    color: Theme.of(context).colorScheme.background,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    plant.name,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                  Text(
                    "${plant.tempMinDay.toInt()}-${plant.tempMaxDay.toInt()}°   ${plant.moistureMin.toInt()}-${plant.moistureMax.toInt()}%",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ],
              ),
              InkWell(
                onLongPress: () {
                  _removePlant(context);
                },
                onTap: () {
                  _handleOnTap(context);
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
        const SizedBox(
          height: 20.0,
        ),
      ],
    );
    ;
  }
}
