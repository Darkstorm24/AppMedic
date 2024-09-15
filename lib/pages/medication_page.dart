import 'package:flutter/material.dart';
import 'package:appmedic/network/model/medication.dart';

class MedicationsPage extends StatelessWidget {
  final List<Medication> medications;
  final Function(int) onRemoveMedication;

  MedicationsPage({required this.medications, required this.onRemoveMedication});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mes Médicaments'),
      ),
      body: ListView.builder(
        itemCount: medications.length,
        itemBuilder: (context, index) {
          final medication = medications[index];
          return Card(
            child: ListTile(
              title: Text(medication.name),
              subtitle: Text(
                'Rappel: ${medication.reminderTimes.map((t) => t.format(context)).join(', ')}\n'
                'Jours: ${medication.days.join(', ')}\n'
                'Notification à l\'écran: ${medication.notifyOnScreen ? 'Oui' : 'Non'}\n'
                'Alarme sonore: ${medication.soundAlarm ? 'Oui' : 'Non'}',
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  onRemoveMedication(index);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
