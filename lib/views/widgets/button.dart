import 'package:flutter/material.dart';

import '../../models/themes.dart';

class MyButton extends StatelessWidget {
  final String label;
  final Function() onTap;

  const MyButton({
    required this.label,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 45,
        width: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9), color: primaryClr),
        alignment: Alignment.center,
        child: Text(
          label,
          style: const TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
