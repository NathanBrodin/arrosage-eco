import 'package:arrosage_eco/pages/selection_page.dart';
import 'package:flutter/material.dart';
import 'package:arrosage_eco/components/header.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title, required this.subtitle});
  final String title;
  final String subtitle;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void openSelectionPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            const SelectionPage(title: "Envie de changement ?", subtitle: "Sélectionnez le type de plante à arroser"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: Header(title: widget.title, subtitle: widget.subtitle),
      body: const Center(),
    );
  }
}
