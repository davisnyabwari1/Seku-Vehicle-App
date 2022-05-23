import 'package:flutter/material.dart';
import 'package:seku_road_app/utilities/constants.dart';

class ProgressDialog extends StatelessWidget {
  final String message;
  ProgressDialog({required this.message});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
          child: Row(
            children: [
              const CircularProgressIndicator(
                color: kStatusColor,
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                message,
                style: kTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
