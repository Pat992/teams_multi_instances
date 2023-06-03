import 'package:flutter/material.dart';

class ErrorSnackBar {
  static void openSnackBar({
    required BuildContext context,
    required String title,
    required String description,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Column(
          children: [
            Row(
              children: [
                const Icon(Icons.error),
                const SizedBox(width: 10),
                Text(title),
              ],
            ),
            Text(description),
          ],
        ),
        backgroundColor: Colors.redAccent,
      ),
    );
  }
}
