import 'package:flutter/material.dart';

class gestureCheck extends StatefulWidget {
  bool check;
  gestureCheck({Key? key, required this.check}) : super(key: key);

  @override
  State<gestureCheck> createState() => _gestureCheckState();
}

class _gestureCheckState extends State<gestureCheck> {
  Color checkColor(bool _check) {
    if (_check) {
      return Colors.green;
    } else
      return Colors.red;
  }

  IconData checkIcon(bool _check) {
    if (_check) {
      return Icons.check;
    } else
      return Icons.close;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: checkColor(widget.check),border: Border.all()),

      child: Icon(checkIcon(widget.check)),
    );
  }
}
