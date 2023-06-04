import 'package:flutter/material.dart';

class ColorPickerButton extends StatelessWidget {
  final Color buttonColor;
  final Color seedColor;
  final Function updateColorSeed;

  const ColorPickerButton({
    Key? key,
    required this.buttonColor,
    required this.seedColor,
    required this.updateColorSeed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(100)),
      onTap: () => updateColorSeed(),
      child: Container(
        decoration: BoxDecoration(
          border: buttonColor == Colors.white
              ? Border.all(
                  color: Colors.black,
                  strokeAlign: BorderSide.strokeAlignOutside,
                )
              : null,
          borderRadius: const BorderRadius.all(Radius.circular(100)),
          boxShadow: [
            BoxShadow(
              color: buttonColor,
              spreadRadius: buttonColor == seedColor ? 2 : 0,
              blurRadius: buttonColor == seedColor ? 7 : 0,
              offset: const Offset(0, 0),
            ),
          ],
          color: buttonColor,
        ),
      ),
    );
  }
}
