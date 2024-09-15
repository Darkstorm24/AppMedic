import 'package:appmedic/pages/results_page.dart';
import 'package:flutter/material.dart';


class ExamResultDetailPage extends StatelessWidget {
  final ExamResult result;

  ExamResultDetailPage({required this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails de l\'examen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              result.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Résultat : ${result.result}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Détails :',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              result.details,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
