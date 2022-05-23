import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:seku_road_app/utilities/constants.dart';

class TopScreenSection extends StatelessWidget {
  final String screenLabel;
  TopScreenSection({required this.screenLabel});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      decoration: BoxDecoration(
          color: Colors.green[700],
          borderRadius:
              const BorderRadius.only(bottomLeft: Radius.circular(100.0))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SvgPicture.asset(
            'assets/logo.svg',
            color: Colors.white,
          ),
          Container(
            alignment: Alignment.bottomRight,
            padding: EdgeInsets.only(right: 10),
            child: Text(
              screenLabel,
              style: kScreenLabel,
            ),
          ),
        ],
      ),
    );
  }
}
