import 'package:flutter/material.dart';
import 'package:appmedic/network/model/appointment.dart';

class AppointmentsPage extends StatefulWidget {
  final List<Appointment> appointments;

  AppointmentsPage({required this.appointments});

  @override
  _AppointmentsPageState createState() => _AppointmentsPageState();
}

class _AppointmentsPageState extends State<AppointmentsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mes Rendez-vous'),
      ),
      body: ListView.builder(
        itemCount: widget.appointments.length,
        itemBuilder: (context, index) {
          final appointment = widget.appointments[index];
          return ListTile(
            title: Text('Dr. ${appointment.doctor.name}'),
            subtitle: Text('Date: ${appointment.date.day}/${appointment.date.month}/${appointment.date.year} à ${appointment.time.format(context)}'),
            trailing: IconButton(
              icon: Icon(Icons.cancel),
              onPressed: () {
                _cancelAppointment(index);
              },
            ),
          );
        },
      ),
    );
  }

  void _cancelAppointment(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Annuler le rendez-vous'),
          content: Text('Voulez-vous vraiment annuler ce rendez-vous ?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Non'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  widget.appointments.removeAt(index);
                });
                Navigator.of(context).pop();
              },
              child: Text('Oui', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
