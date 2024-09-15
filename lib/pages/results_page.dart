import 'package:flutter/material.dart';
import 'package:appmedic/pages/Result_detail_page.dart';

// Modèle de données pour les résultats d'examen
class ExamResult {
  final String name;
  final String result;
  final String details;

  ExamResult({required this.name, required this.result, required this.details});
}

class ResultsPage extends StatelessWidget {
  // Liste fictive de résultats d'examen
  final List<ExamResult> examResults = [
    ExamResult(
      name: 'Analyse de sang',
      result: 'Normal',
      details: 'L\'analyse de sang montre des valeurs normales pour tous les paramètres mesurés.',
    ),
    ExamResult(
      name: 'Radiographie',
      result: 'Anomalie détectée',
      details: 'La radiographie montre une fracture au niveau du bras droit. Recommandation : Consultez un orthopédiste pour un traitement approprié.',
    ),
    ExamResult(
      name: 'Électrocardiogramme',
      result: 'Normal',
      details: 'L\'électrocardiogramme ne montre aucune anomalie dans l\'activité électrique du cœur.',
    ),
    // Ajoutez plus de résultats d'examen si nécessaire
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Résultats d\'examen'),
      ),
      body: ListView.builder(
        itemCount: examResults.length,
        itemBuilder: (context, index) {
          final result = examResults[index];
          return Card(
            color: index % 2 == 0 ? Colors.blue[50] : Colors.white, // Alterner les couleurs des cartes
            child: ListTile(
              title: Text(
                result.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              subtitle: Text('Résultat : ${result.result}'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExamResultDetailPage(result: result),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
