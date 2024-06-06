import 'package:appmedic/pages/register_page.dart';
import 'package:appmedic/theme.dart';
import 'package:appmedic/widget/button_primary.dart';
import 'package:appmedic/widget/general_login_space.dart';
import 'package:appmedic/widget/widget_illustration.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: GeneralLoginSpace(
        child: Column(
          children: [
            SizedBox(
              height: 45,
            ),
            WidgetIllustration(
              image: "assets/splash_ilustration.png",
              title: "Find your medical solution",
              subtitle1: "Consult with a doctor",
              subtitle2: "Whereever and whenever you want",
              child: ButtonPrimary(
                text: "GET STARTED", 
                onTap: () {
                  Navigator.pushReplacement(context,
                   MaterialPageRoute(builder: (context) => RegisterPage()));
                },),
            ),
          ],
        ),
        ),
    );
  }
}