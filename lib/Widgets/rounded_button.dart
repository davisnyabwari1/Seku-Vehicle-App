import 'package:flutter/material.dart';
import 'package:seku_road_app/utilities/constants.dart';

class RoundButton extends StatelessWidget {
  final String label;
  RoundButton({required this.label});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      height: 50,
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(100),
        ),
        color: Colors.green[700],
      ),
      child: Text(
        label,
        style: kButtonTextDecoration,
      ),
    );
  }
}
