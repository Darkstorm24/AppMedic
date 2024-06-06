import 'package:appmedic/theme.dart';
import 'package:flutter/material.dart';

class WidgetIllustration extends StatelessWidget {
  final Widget? child;
  final String? image;
  final String? title;
  final String? subtitle1;
  final String? subtitle2;

  WidgetIllustration({ this.child,  this.image, this.title, this.subtitle1,  this.subtitle2});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Image.asset("assets/splash_ilustration.png",
      width: 250,
      ),
      SizedBox(
        height: 30,),
      Text(
        title!, 
        style: regularTextStyle.copyWith(fontSize: 25),
        textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 16,
        ),
        Column(
          children: [
            Text(subtitle1!, style: regularTextStyle.copyWith(
              fontSize: 15, color: greyLightColor),
              ),
              SizedBox(
                height: 8,
              ),
              Text(subtitle2!, style: regularTextStyle.copyWith(
              fontSize: 15, color: greyLightColor),
              ),
               SizedBox(
                height: 40,
              ),
              child ?? SizedBox(),
          ],
        ),
      ],
    );
  }
}