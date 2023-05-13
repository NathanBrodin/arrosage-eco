import 'package:flutter/material.dart';

class AddIp extends AlertDialog {
  AddIp({Key? key, required this.confirmIp}) : super(key: key);
  Function(String)? confirmIp;

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      backgroundColor: Theme.of(context).colorScheme.background,
      title: const Text('Entre ton addresse IP'),
      content: TextField(
        controller: _controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.only(
              top: 10.0, bottom: 10.0, left: 20.0, right: 20.0),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.secondary),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
        ),
      ),
      actions: <Widget>[
        InkWell(
          onTap: () {
            confirmIp!(_controller.text);
            Navigator.pop(context);
          },
          child: Container(
            padding: const EdgeInsets.only(
                left: 40.0, right: 40.0, top: 5.0, bottom: 5.0),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20.0)),
              color: Theme.of(context).colorScheme.secondary,
            ),
            child: Text(
              "Confirmer",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
