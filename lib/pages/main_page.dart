import 'package:appmedic/pages/home_page.dart'; // Importe la page d'accueil
import 'package:appmedic/pages/MedicAlarm_page.dart';
import 'package:appmedic/pages/booking_page.dart'; // Importe la page de résultats
import 'package:appmedic/pages/results_page.dart';
import 'package:appmedic/pages/setting_page.dart';
import 'package:appmedic/theme.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    HomePage(), // Ajoute la page d'accueil en première position
    BookingPage(),
    MedicAlarmPage(onAddMedication: (Medication ) {  },),
    ResultsPage(), // Remplace ChatbotPage par ResultsPage
    SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ZeMedic'),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_online),
            label: 'Booking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.alarm),
            label: 'Medic Alarm',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Results', // Label pour la page de résultats
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: purpleColor,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
