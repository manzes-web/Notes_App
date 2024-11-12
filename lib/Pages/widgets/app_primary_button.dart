import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppPrimaryButton extends StatelessWidget {
  final Function()? onTap;
  const AppPrimaryButton({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.secondary, borderRadius: BorderRadius.circular(12)),
        child: const Text('Update'),
      ),
    );
  }
}
