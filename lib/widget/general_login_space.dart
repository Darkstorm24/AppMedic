import 'package:flutter/material.dart';

class GeneralLoginSpace extends StatelessWidget {
  final Widget? child;
  GeneralLoginSpace({this.child});
  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Image.asset(
          "assets/logo.png",
          width: 115,
          ),
          child ?? SizedBox()
        ],),
    );
  }
}

