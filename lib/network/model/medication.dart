import 'package:flutter/material.dart';

class Medication {
  final String name;
  final List<TimeOfDay> reminderTimes;
  final List<String> days;
  final String frequency;
  final bool notifyOnScreen;
  final bool soundAlarm;

  Medication({
    required this.name,
    required this.reminderTimes,
    required this.days,
    required this.frequency,
    required this.notifyOnScreen,
    required this.soundAlarm,
  });

  // Méthode pour convertir un objet Medication en Map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'reminderTimes': reminderTimes.map((time) => '${time.hour}:${time.minute}').toList(),
      'days': days,
      'frequency': frequency,
      'notifyOnScreen': notifyOnScreen,
      'soundAlarm': soundAlarm,
    };
  }

  // Méthode pour créer un objet Medication à partir d'une Map
  factory Medication.fromMap(Map<String, dynamic> map) {
    return Medication(
      name: map['name'],
      reminderTimes: List<TimeOfDay>.from(map['reminderTimes'].map((time) {
        final parts = time.split(':');
        return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
      })),
      days: List<String>.from(map['days']),
      frequency: map['frequency'],
      notifyOnScreen: map['notifyOnScreen'],
      soundAlarm: map['soundAlarm'],
    );
  }
}
