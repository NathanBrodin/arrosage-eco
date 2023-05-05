import 'package:arrosage_eco/modele/plant.dart';
import 'package:flutter/material.dart';

class AddNew extends StatefulWidget {
  const AddNew({Key? key, required this.updatePlants, required  this.maxId}) : super(key: key);
  final Function(Plant) updatePlants;
  final int maxId;

  @override
  State<AddNew> createState() => _AddNewState();
}

class _AddNewState extends State<AddNew> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _controller = TextEditingController();
  RangeValues _currentRangeValuesTemp = const RangeValues(15, 25);
  RangeValues _currentRangeValuesMoisture = const RangeValues(10, 60);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        color: Theme.of(context).colorScheme.background,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Pas assez de choix ?",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    "Créer ta propre plante",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.close_rounded,
                  size: 40,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 3,
                color: Theme.of(context).colorScheme.primary,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(20.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Nom de la plante",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        TextFormField(
                          controller: _controller,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Le nom ne peut être vide';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.only(
                                top: 10.0,
                                bottom: 10.0,
                                left: 20.0,
                                right: 20.0),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide:
                                  const BorderSide(color: Colors.transparent),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Températures supportées",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        RangeSlider(
                          values: _currentRangeValuesTemp,
                          min: 0,
                          max: 30,
                          divisions: 30,
                          labels: RangeLabels(
                            _currentRangeValuesTemp.start.round().toString(),
                            _currentRangeValuesTemp.end.round().toString(),
                          ),
                          onChanged: (RangeValues values) {
                            setState(
                              () {
                                _currentRangeValuesTemp = values;
                              },
                            );
                          },
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Humiditées supportées",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        RangeSlider(
                          values: _currentRangeValuesMoisture,
                          min: 0,
                          max: 100,
                          divisions: 50,
                          labels: RangeLabels(
                            _currentRangeValuesMoisture.start
                                .round()
                                .toString(),
                            _currentRangeValuesMoisture.end.round().toString(),
                          ),
                          onChanged: (RangeValues values) {
                            setState(
                              () {
                                _currentRangeValuesMoisture = values;
                              },
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    InkWell(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            Plant newPlant = Plant(id: widget.maxId, name: _controller.text, moistureMin: _currentRangeValuesMoisture.start, moistureMax: _currentRangeValuesMoisture.end, tempMinDay: _currentRangeValuesTemp.start, tempMaxDay: _currentRangeValuesTemp.end, tempMinNight: 0, tempMaxNight: 0);
                            widget.updatePlants(newPlant);

                            Navigator.pop(context);
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 40.0, right: 40.0, top: 5.0, bottom: 5.0),
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20.0)),
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          child: Text(
                            "Confirmer",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(color: Colors.white),
                          ),
                        ))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
