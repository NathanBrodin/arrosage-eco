import 'package:flutter/material.dart';

class Water extends StatelessWidget {
  const Water({Key? key, required this.percentage}) : super(key: key);
  final int percentage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
          child: Container(
            // Adjust the width and height as needed
            width: 40.0, // to change the circle's size
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Theme.of(context).colorScheme.onPrimary,
                  Theme.of(context).colorScheme.background,
                ],
                stops: [percentage / 100, percentage / 100],
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 20.0,
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${percentage.toString()}%",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                "d'eau",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
