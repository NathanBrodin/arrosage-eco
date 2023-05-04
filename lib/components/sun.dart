import 'package:flutter/material.dart';

class Sun extends StatelessWidget {
  const Sun({Key? key, required this.value}) : super(key: key);
  final int value;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 60, // Adjust the width and height as needed
          height: 60, // to change the circle's size
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                Theme.of(context).colorScheme.secondary,
                Theme.of(context).colorScheme.secondary.withOpacity(0.5),
              ],
              stops: [value / 100, value / 100],
              center: Alignment.center,
              radius: 0.5,
            ),
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${value.toString()}%",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                "d'ensolleilement",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 14,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
