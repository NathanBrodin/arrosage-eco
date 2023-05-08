import 'package:flutter/material.dart';

class BasePage extends StatelessWidget {
  final Widget header;
  final Widget content;

  const BasePage({Key? key, required this.header, required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          header,
          Expanded(child: content),
        ],
      ),
    );
  }
}
