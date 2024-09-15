import 'package:appmedic/network/model/doctor.dart';
import 'package:flutter/material.dart';

class Appointment {
  final Doctor doctor;
  final DateTime date;
  final TimeOfDay time;

  Appointment({required this.doctor, required this.date, required this.time});
}
