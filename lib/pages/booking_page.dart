import 'package:flutter/material.dart';
import 'package:appmedic/network/model/doctor.dart';
import 'package:appmedic/network/model/appointment.dart';
import 'package:appmedic/pages/doctor_detail_page.dart';
import 'package:appmedic/pages/appointments_page.dart';

class BookingPage extends StatefulWidget {
  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  List<Doctor> doctors = [
    Doctor(
      name: "Dr. Smith",
      specialty: "Cardiology",
      profileImageUrl: "assets/images/doctor5.jpg",
      description:
          "Dr. Smith est un cardiologue expérimenté avec 10 ans d'expérience. Il est diplômé de l'Université XYZ et a une expertise dans le traitement des maladies cardiaques.",
    ),
    Doctor(
      name: "Dr. Johnson",
      specialty: "Dermatology",
      profileImageUrl: "assets/images/doctor6.jpg",
      description:
          "Dr. Johnson est dermatologue spécialisé dans les soins de la peau. Avec 8 ans d'expérience, elle a aidé de nombreux patients à améliorer leur santé cutanée.",
    ),
    Doctor(
      name: "Dr. Williams",
      specialty: "Neurology",
      profileImageUrl: "assets/images/doctor7.jpg",
      description:
          "Dr. Williams est neurologue avec 12 ans d'expérience. Il a étudié à l'Université ABC et se spécialise dans le traitement des troubles neurologiques.",
    ),
    // Add more doctors here
  ];

  List<Appointment> appointments = [];
  List<Doctor> filteredDoctors = [];

  @override
  void initState() {
    super.initState();
    filteredDoctors = doctors;
  }

  void filterDoctors(String query) {
    List<Doctor> filtered = doctors.where((doctor) {
      return doctor.name.toLowerCase().contains(query.toLowerCase()) ||
          doctor.specialty.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      filteredDoctors = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prendre Rendez-vous'),
        actions: [
          IconButton(
            icon: Icon(Icons.view_list),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AppointmentsPage(appointments: appointments),
                ),
              ).then((_) {
                setState(() {}); // Update the state to reflect new appointments
              });
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                filterDoctors(value);
              },
              decoration: InputDecoration(
                hintText: 'Rechercher un docteur ou une spécialité...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: filteredDoctors.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 3,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
             leading: CircleAvatar(
  backgroundImage: AssetImage(filteredDoctors[index].profileImageUrl),
),
              title: Text(
                filteredDoctors[index].name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(filteredDoctors[index].specialty),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DoctorDetailPage(
                      doctor: filteredDoctors[index],
                      appointments: appointments,
                    ),
                  ),
                ).then((_) {
                  setState(() {}); // Update the state to reflect new appointments
                });
              },
            ),
          );
        },
      ),
    );
  }
}
