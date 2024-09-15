import 'package:appmedic/network/model/medication.dart';
import 'package:appmedic/network/model/notification_service.dart';
import 'package:flutter/material.dart';

class MedicAlarmPage extends StatefulWidget {
  final Function(Medication) onAddMedication;

  MedicAlarmPage({required this.onAddMedication});

  @override
  _MedicAlarmPageState createState() => _MedicAlarmPageState();
}

class _MedicAlarmPageState extends State<MedicAlarmPage> {
  TextEditingController nameController = TextEditingController();
  List<TimeOfDay> reminderTimes = [];
  List<String> days = [];
  String frequency = 'Une fois';
  bool notifyOnScreen = true;
  bool soundAlarm = true;

  bool isLoading = false;

  Future<void> _scheduleReminders(String medicationName) async {
    for (int i = 0; i < reminderTimes.length; i++) {
      final time = reminderTimes[i];
      final now = DateTime.now();
      for (String day in days) {
        final scheduledTime = DateTime(now.year, now.month, now.day, time.hour, time.minute);
        await NotificationService.scheduleNotification(
          i,
          'Prendre votre médicament',
          'Il est temps de prendre $medicationName',
          scheduledTime,
          soundAlarm: soundAlarm,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter un médicament et un rappel'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Nom du médicament'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (pickedTime != null) {
                  setState(() {
                    reminderTimes.add(pickedTime);
                  });
                }
              },
              child: Text('Ajouter une heure de rappel'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final selectedDays = await showDialog<List<String>>(
                  context: context,
                  builder: (context) => SelectDaysDialog(selectedDays: days),
                );
                if (selectedDays != null) {
                  setState(() {
                    days = selectedDays;
                  });
                }
              },
              child: Text('Choisir les jours de rappel'),
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              value: frequency,
              onChanged: (String? newValue) {
                setState(() {
                  frequency = newValue!;
                });
              },
              items: <String>['Une fois', 'Chaque heure', 'Toutes les 2 heures']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            SwitchListTile(
              title: Text('Notification à l\'écran'),
              value: notifyOnScreen,
              onChanged: (bool value) {
                setState(() {
                  notifyOnScreen = value;
                });
              },
            ),
            SwitchListTile(
              title: Text('Alarme sonore'),
              value: soundAlarm,
              onChanged: (bool value) {
                setState(() {
                  soundAlarm = value;
                });
              },
            ),
            Expanded(
              child: ListView.builder(
                itemCount: reminderTimes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Rappel à ${reminderTimes[index].format(context)}'),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                if (nameController.text.isNotEmpty && reminderTimes.isNotEmpty && days.isNotEmpty) {
                  setState(() {
                    isLoading = true;
                  });
                  Medication medication = Medication(
                    name: nameController.text,
                    reminderTimes: reminderTimes,
                    days: days,
                    frequency: frequency,
                    notifyOnScreen: notifyOnScreen,
                    soundAlarm: soundAlarm,
                  );
                  widget.onAddMedication(medication);
                  await _scheduleReminders(nameController.text);
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Veuillez entrer un nom de médicament, au moins une heure de rappel, et sélectionner les jours.'),
                    ),
                  );
                }
              },
              child: isLoading ? CircularProgressIndicator() : Text('Enregistrer'),
            ),
          ],
        ),
      ),
    );
  }
}

class SelectDaysDialog extends StatefulWidget {
  final List<String> selectedDays;

  SelectDaysDialog({required this.selectedDays});

  @override
  _SelectDaysDialogState createState() => _SelectDaysDialogState();
}

class _SelectDaysDialogState extends State<SelectDaysDialog> {
  List<String> days = ['Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi', 'Samedi', 'Dimanche'];
  List<String> selectedDays = [];

  @override
  void initState() {
    super.initState();
    selectedDays = widget.selectedDays;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Choisir les jours'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: days.map((day) {
          return CheckboxListTile(
            title: Text(day),
            value: selectedDays.contains(day),
            onChanged: (bool? value) {
              setState(() {
                if (value == true) {
                  selectedDays.add(day);
                } else {
                  selectedDays.remove(day);
                }
              });
            },
          );
        }).toList(),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Annuler'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(selectedDays);
          },
          child: Text('OK'),
        ),
      ],
    );
  }
}
