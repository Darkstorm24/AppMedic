import 'dart:math';
import 'package:flutter/material.dart';

// Modèle pour les articles de feed
class FeedItem {
  final String title;
  final String content;
  final String imageUrl;

  FeedItem({required this.title, required this.content, required this.imageUrl});
}

// Modèle pour les docteurs
class Doctor {
  final String name;
  final String specialty;
  final String imageUrl;

  Doctor({required this.name, required this.specialty, required this.imageUrl});
}

// Liste des docteurs par spécialité
Map<String, List<Doctor>> doctorsBySpecialty = {
  'Cardiology': [
    Doctor(name: 'Dr. Heart', specialty: 'Cardiology', imageUrl: 'https://via.placeholder.com/150'),
    Doctor(name: 'Dr. Pulse', specialty: 'Cardiology', imageUrl: 'https://via.placeholder.com/150'),
  ],
  'Dermatology': [
    Doctor(name: 'Dr. Skin', specialty: 'Dermatology', imageUrl: 'https://via.placeholder.com/150'),
    Doctor(name: 'Dr. Smooth', specialty: 'Dermatology', imageUrl: 'https://via.placeholder.com/150'),
  ],
  'Neurology': [
    Doctor(name: 'Dr. Brain', specialty: 'Neurology', imageUrl: 'https://via.placeholder.com/150'),
    Doctor(name: 'Dr. Nerve', specialty: 'Neurology', imageUrl: 'https://via.placeholder.com/150'),
  ],
  'Pediatrics': [
    Doctor(name: 'Dr. Kid', specialty: 'Pediatrics', imageUrl: 'https://via.placeholder.com/150'),
    Doctor(name: 'Dr. Child', specialty: 'Pediatrics', imageUrl: 'https://via.placeholder.com/150'),
  ],
  'Radiology': [
    Doctor(name: 'Dr. X-ray', specialty: 'Radiology', imageUrl: 'https://via.placeholder.com/150'),
    Doctor(name: 'Dr. Scan', specialty: 'Radiology', imageUrl: 'https://via.placeholder.com/150'),
  ],
  'Surgery': [
    Doctor(name: 'Dr. Cut', specialty: 'Surgery', imageUrl: 'https://via.placeholder.com/150'),
    Doctor(name: 'Dr. Stitch', specialty: 'Surgery', imageUrl: 'https://via.placeholder.com/150'),
  ],
};

// Page d'accueil avec le feed
class HomePage extends StatelessWidget {
  // Génère des données aléatoires pour le feed
  List<FeedItem> generateRandomFeed() {
    // Exemple de données aléatoires
    List<String> titles = ["Conseils santé", "Maladie du jour", "Recette nutritive", "Entraînement du jour"];
    List<String> contents = [
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
      "Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
      "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
      "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur."
    ];
    List<String> imageUrls = [
      "assets/images/feed1.jpg",
      "assets/images/feed2.jpg",
      "assets/images/feed3.jpg",
      "assets/images/feed4.jpg"
    ];

    List<FeedItem> feed = [];
    Random random = Random();

    // Génère 10 articles de feed
    for (int i = 0; i < 10; i++) {
      int index = random.nextInt(titles.length);
      feed.add(FeedItem(title: titles[index], content: contents[index], imageUrl: imageUrls[index]));
    }

    return feed;
  }

  @override
  Widget build(BuildContext context) {
    // Génère des données aléatoires pour le feed
    List<FeedItem> feed = generateRandomFeed();

    return Scaffold(
      appBar: AppBar(
        title: Text('Hello,'),
       // backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Section pour choisir les spécialités médicales
            Container(
              height: 140,
              padding: EdgeInsets.symmetric(vertical: 10),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  SpecialtyCard(iconPath: 'assets/icons/heart.png', label: 'Cardiology', color: Colors.red),
                  SpecialtyCard(iconPath: 'assets/icons/skin.png', label: 'Dermatology', color: Colors.green),
                  SpecialtyCard(iconPath: 'assets/icons/brain.png', label: 'Neurology', color: Colors.purple),
                  SpecialtyCard(iconPath: 'assets/icons/child.png', label: 'Pediatrics', color: Colors.orange),
                  SpecialtyCard(iconPath: 'assets/icons/radiology.png', label: 'Radiology', color: Colors.blue),
                  SpecialtyCard(iconPath: 'assets/icons/surgery.png', label: 'Surgery', color: Colors.teal),
                ],
              ),
            ),
            // Utilisation de Flexible pour la liste des articles
            Container(
              height: MediaQuery.of(context).size.height - 200,
              child: ListView.builder(
                itemCount: feed.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 5,
                    child: ListTile(
                      title: Text(
                        feed[index].title,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(feed[index].content),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(feed[index].imageUrl, width: 50, height: 50, fit: BoxFit.cover),
                      ),
                      onTap: () {
                        // Afficher plus de détails lorsqu'un article est tapé
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FeedDetailPage(feedItem: feed[index]),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SpecialtyCard extends StatelessWidget {
  final String iconPath;
  final String label;
  final Color color;

  SpecialtyCard({required this.iconPath, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DoctorListPage(specialty: label),
          ),
        );
      },
      child: Container(
        width: 100,
        margin: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: color.withOpacity(0.1),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset(iconPath, color: color),
              ),
            ),
            SizedBox(height: 10),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withOpacity(0.3)),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.1),
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
      ),
    );
  }
}

class FeedDetailPage extends StatelessWidget {
  final FeedItem feedItem;

  FeedDetailPage({required this.feedItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(feedItem.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(feedItem.imageUrl),
              SizedBox(height: 20),
              Text(
                feedItem.title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(feedItem.content),
            ],
          ),
        ),
      ),
    );
  }
}

class DoctorListPage extends StatelessWidget {
  final String specialty;

  DoctorListPage({required this.specialty});

  @override
  Widget build(BuildContext context) {
    List<Doctor> doctors = doctorsBySpecialty[specialty] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text(specialty),
      ),
      body: ListView.builder(
        itemCount: doctors.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 5,
            child: ListTile(
              title: Text(
                doctors[index].name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(doctors[index].specialty),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(doctors[index].imageUrl, width: 50, height: 50, fit: BoxFit.cover),
              ),
              onTap: () {
                // Afficher plus de détails lorsqu'un docteur est tapé
              },
            ),
          );
        },
      ),
    );
  }
}
