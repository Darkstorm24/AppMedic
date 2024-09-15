import 'package:appmedic/network/model/notification_service.dart';
import 'package:appmedic/pages/splash_screen.dart';
import 'package:appmedic/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
 // Import du service de notification si nécessaire
import 'package:timezone/data/latest.dart' as tz;


void main() async {
  // Assure que les bindings Flutter sont initialisés
  WidgetsFlutterBinding.ensureInitialized();

  // Initialise le service de notification si nécessaire
  NotificationService.initialize();

  // Initialise les fuseaux horaires
  tz.initializeTimeZones();

  // Restreint l'orientation de l'application en mode portrait uniquement
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // Lance l'application avec votre MaterialApp
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: whiteColor),
      home: SplashScreen(),
    );
  }
}
