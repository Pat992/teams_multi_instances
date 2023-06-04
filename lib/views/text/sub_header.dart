import 'package:flutter/material.dart';

class SubHeader extends StatelessWidget {
  final String text;

  const SubHeader({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 18),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
