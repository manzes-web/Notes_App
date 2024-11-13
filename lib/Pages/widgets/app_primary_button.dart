import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppPrimaryButton extends StatelessWidget {
  final String? buttonText;
  final Function()? onTap;
  final Color? color;
  const AppPrimaryButton({super.key, this.onTap, this.buttonText, this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: color ?? Theme.of(context).colorScheme.secondary, borderRadius: BorderRadius.circular(12)),
        child: Text('$buttonText'),
      ),
    );
  }
}
