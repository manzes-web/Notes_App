import 'package:flutter/material.dart';

class Apptextfield extends StatelessWidget {
  final TextEditingController textController;
  final String labelText;
  final Function()? onTap;

  const Apptextfield({super.key, required this.textController, required this.labelText, this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: onTap,
      onTapOutside: (e) => FocusScope.of(context).unfocus(),
      controller: textController,
      cursorColor: Theme.of(context).colorScheme.inversePrimary,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
        focusColor: Theme.of(context).colorScheme.inversePrimary,
        border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Theme.of(context).colorScheme.inversePrimary)),
        focusedBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Theme.of(context).colorScheme.inversePrimary)),
      ),
    );
  }
}
