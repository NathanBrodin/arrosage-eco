import 'package:arrosage_eco/components/battery.dart';
import 'package:arrosage_eco/components/current_plant.dart';
import 'package:arrosage_eco/components/small_card.dart';
import 'package:arrosage_eco/components/sun.dart';
import 'package:arrosage_eco/components/water.dart';
import 'package:arrosage_eco/modele/infos.dart';
import 'package:arrosage_eco/modele/plant.dart';
import 'package:arrosage_eco/pages/base_page.dart';
import 'package:flutter/material.dart';
import 'package:arrosage_eco/components/header.dart';

class HomePage extends StatefulWidget {
  const HomePage(
      {Key? key,
      required this.infos,
      required this.plants,
      required this.currentPlant,
      required this.title,
      required this.subtitle,
      required this.update,
      required this.sendCurrentPlant,
      required this.changeIp})
      : super(key: key);
  final Infos infos;
  final List<Plant> plants;
  final Plant currentPlant;
  final String title;
  final String subtitle;
  final Function(Plant, String) update;
  final Function(Plant) sendCurrentPlant;
  final Function(String) changeIp;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: BasePage(
        header: Header(
          title: 'Bienvenue !',
          subtitle: "Votre système d'arrosage est au point",
          changeIp: widget.changeIp,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                flex: 150,
                child: Row(
                  children: [
                    Flexible(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20),
                            ),
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          child: Battery(
                            percentage: widget.infos.battery,
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                            color: Colors.white,
                          ),
                          child: Sun(
                            value: widget.infos.sun,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 210,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                              color: Colors.white,
                            ),
                            child: Water(
                              percentage: widget.infos.water,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(20)),
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary),
                                    child: SmallCard(
                                      title:
                                          "${widget.infos.moisture.toString()}%",
                                      subtitle: "d'humidité",
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(20)),
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary),
                                    child: SmallCard(
                                        title:
                                            "${widget.infos.temperature.toString()}°",
                                        subtitle: "de température"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 210,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    child: CurrentPlant(
                      plant: widget.currentPlant,
                      plants: widget.plants,
                      update: widget.update,
                      sendCurrentPlant: widget.sendCurrentPlant,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
