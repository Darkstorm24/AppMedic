import 'package:appmedic/theme.dart';
import 'package:flutter/material.dart';
import 'package:appmedic/network/model/doctor.dart';
import 'package:appmedic/network/model/appointment.dart';

class DoctorDetailPage extends StatefulWidget {
  final Doctor doctor;
  final List<Appointment> appointments;

  DoctorDetailPage({required this.doctor, required this.appointments});

  @override
  _DoctorDetailPageState createState() => _DoctorDetailPageState();
}

class _DoctorDetailPageState extends State<DoctorDetailPage> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails du ${widget.doctor.name}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(widget.doctor.profileImageUrl),
              ),
            ),
            SizedBox(height: 20),
            Text(
              widget.doctor.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Spécialité: ${widget.doctor.specialty}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'Description:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              widget.doctor.description,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                _selectDate(context);
              },
              icon: Icon(Icons.calendar_today),
              label: Text(selectedDate == null ? 'Choisir la date du rendez-vous' : 'Date: ${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'),
            ),
            SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {
                _selectTime(context);
              },
              icon: Icon(Icons.access_time),
              label: Text(selectedTime == null ? 'Choisir l\'heure du rendez-vous' : 'Heure: ${selectedTime!.hour}:${selectedTime!.minute}'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _confirmAppointment(context);
              },
               style: ElevatedButton.styleFrom(
          backgroundColor: purpleColor),
              child: Text('Confirmer le rendez-vous', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  void _confirmAppointment(BuildContext context) {
    if (selectedDate != null && selectedTime != null) {
      final appointment = Appointment(
        doctor: widget.doctor,
        date: selectedDate!,
        time: selectedTime!,
      );

      setState(() {
        widget.appointments.add(appointment);
      });

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Confirmation de rendez-vous'),
            content: Text('Rendez-vous réservé avec ${widget.doctor.name} le ${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year} à ${selectedTime!.hour}:${selectedTime!.minute}'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK', style: TextStyle(color: Colors.blue)),
              ),
            ],
          );
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Veuillez choisir une date et une heure pour le rendez-vous'),
        ),
      );
    }
  }
}
