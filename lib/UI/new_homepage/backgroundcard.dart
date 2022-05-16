import 'package:flutter/material.dart';

import '../size_config.dart';

class BackgroundCard extends StatelessWidget {
  const BackgroundCard(
      {Key? key,
      required this.child,
      this.height,
      required this.topMargin,
      this.width})
      : super(key: key);
  final width;
  final height;
  final double topMargin;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: topMargin, left: 20, right: 20),
      width: SizeConfig.safeBlockHorizontal * width,
      height: SizeConfig.safeBlockVertical * height,
      decoration: BoxDecoration(
        color: Color(0xffF3F2F2),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 5,
              spreadRadius: 4),
        ],
      ),
      child: child,
    );
  }
}
