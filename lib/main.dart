

import 'package:appmedic/pages/splash_screen.dart';
import 'package:appmedic/theme.dart';
import 'package:flutter/material.dart';

void main() =>runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
    Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: whiteColor),
      home: SplashScreen(
      ),
    ) ;
  }
}