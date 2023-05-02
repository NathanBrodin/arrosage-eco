import 'package:flutter/material.dart';
import 'package:arrosage_eco/components/header.dart';

class SelectionPage extends StatefulWidget {
  const SelectionPage({super.key, required this.title, required this.subtitle});
  final String title;
  final String subtitle;

  @override
  _SelectionPageState createState() => _SelectionPageState();
}

class _SelectionPageState extends State<SelectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: Header(title: widget.title, subtitle: widget.subtitle),
      body: const Center(),
    );
  }
}
