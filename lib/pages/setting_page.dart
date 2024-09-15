import 'package:flutter/material.dart';
import 'package:appmedic/pages/login_page.dart'; // Importez la page LoginPages ici

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Paramètres'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.language),
            title: Text('Langue'),
            onTap: () {
              // Naviguer vers la page de sélection de la langue
            },
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notifications'),
            onTap: () {
              // Naviguer vers la page de paramètres de notification
            },
          ),
          ListTile(
            leading: Icon(Icons.security),
            title: Text('Paramètres de confidentialité'),
            onTap: () {
              // Naviguer vers la page de paramètres de confidentialité
            },
          ),
          ListTile(
            leading: Icon(Icons.color_lens),
            title: Text('Thème de l\'application'),
            onTap: () {
              // Naviguer vers la page de sélection de thème
            },
          ),
          ListTile(
            leading: Icon(Icons.volume_up),
            title: Text('Sonneries'),
            onTap: () {
              // Naviguer vers la page de sélection de sonneries
            },
          ),
          ListTile(
            leading: Icon(Icons.history),
            title: Text('Historique des données'),
            onTap: () {
              // Naviguer vers la page d'historique des données
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('À propos'),
            onTap: () {
              // Naviguer vers la page À propos de l'application
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app), // Icône de déconnexion
            title: Text('Déconnexion'), // Texte de l'option de déconnexion
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginPages()),
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
