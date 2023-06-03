import 'package:flutter/material.dart';

class DialogOpener {
  static void openDialog({
    required Widget dialog,
    required BuildContext context,
  }) {
    showDialog(context: context, builder: (context) => dialog);
  }
}
