import 'package:arrosage_eco/components/battery.dart';
import 'package:arrosage_eco/components/current_plant.dart';
import 'package:arrosage_eco/components/small_card.dart';
import 'package:arrosage_eco/components/sun.dart';
import 'package:arrosage_eco/components/water.dart';
import 'package:arrosage_eco/modele/infos.dart';
import 'package:arrosage_eco/modele/plant.dart';
import 'package:arrosage_eco/pages/selection_page.dart';
import 'package:flutter/material.dart';
import 'package:arrosage_eco/components/header.dart';

class HomePage extends StatefulWidget {
  const HomePage(
      {Key? key,
      required this.infos,
      required this.currentPlant,
      required this.title,
      required this.subtitle})
      : super(key: key);
  final Infos infos;
  final Plant currentPlant;
  final String title;
  final String subtitle;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: Header(title: widget.title, subtitle: widget.subtitle),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 90.0), // TODO: CHANGER CA PAR 90.0
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
            ),
            Expanded(
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
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
