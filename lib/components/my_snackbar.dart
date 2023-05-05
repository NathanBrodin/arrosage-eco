import 'package:flutter/material.dart';

class MySnackbar extends SnackBar {
  MySnackbar({
    Key? key,
    required BuildContext context,
    required String priority,
    required String text,
    required IconData icon,
  }) : super(
          key: key,
          content: Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: _getColor(priority, context),
              borderRadius: const BorderRadius.all(
                Radius.circular(20.0),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.background,
                  ),
                  child: Icon(
                    icon,
                    size: 20.0,
                    color: _getColor(priority, context),
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Flexible(
                  child: Text(
                    text,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.transparent,
        );

  static Color _getColor(String priority, BuildContext context) {
    Map<String, Color> colors = {
      "info": Theme.of(context).colorScheme.secondary,
      "error": const Color(0xFFFB4D42),
    };
    return colors[priority]!;
  }
}
