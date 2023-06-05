import 'package:arrosage_eco/components/my_snackbar.dart';
import 'package:arrosage_eco/modele/plant.dart';
import 'package:arrosage_eco/pages/selection_page.dart';
import 'package:flutter/material.dart';

class CurrentPlant extends StatefulWidget {
  CurrentPlant(
      {Key? key,
      required this.plant,
      required this.plants,
      required this.update,
      required this.sendCurrentPlant})
      : super(key: key);
  Plant plant;
  final List<Plant> plants;
  final Function(Plant, String) update;
  final Function(Plant) sendCurrentPlant;

  @override
  State<CurrentPlant> createState() => _CurrentPlantState();
}

class _CurrentPlantState extends State<CurrentPlant> {
  void updateCurrentPlant(Plant newPlant) {
    widget.sendCurrentPlant(newPlant);

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

    setState(() {
      widget.plant = newPlant;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Vous arrosez actuellement:",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                    ),
              ),
              Text(
                widget.plant.name,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                    ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  border: Border.all(
                    width: 3.0,
                    color: Theme.of(context).colorScheme.background,
                  ),
                ),
                child: Image.asset("assets/images/${widget.plant.image}"),  // https://www.pngwing.com/
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SelectionPage(
                          title: "Envie de changement ?",
                          subtitle: "Sélectionnez le type de plante à arroser",
                          plants: widget.plants,
                          id: widget.plant.id,
                          updateCurrentPlant: updateCurrentPlant,
                          update: widget.update),
                    ),
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
                    Icons.arrow_forward_rounded,
                    size: 40,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
