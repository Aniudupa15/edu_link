import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Attendance extends StatefulWidget {
  const Attendance({super.key});

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String _attendanceStatus = 'Loading...';
  double? attendancePercentage;
  int? classesAttended;
  int? totalClasses;

  @override
  void initState() {
    super.initState();
    _fetchAttendanceStatus();
  }

  void logout() async {
    await _auth.signOut();
    Navigator.of(context).pop(); // Optionally navigate back to a previous screen
  }

  Future<void> _fetchAttendanceStatus() async {
    User? user = _auth.currentUser;
    if (user != null) {
      try {
        DocumentSnapshot snapshot =
        await _firestore.collection('Attendance').doc(user.email).get();
        if (snapshot.exists) {
          setState(() {
            attendancePercentage = snapshot['attendancePercentage']?.toDouble();
            classesAttended = snapshot['classesAttended']?.toInt();
            totalClasses = snapshot['totalClasses']?.toInt();
            _attendanceStatus = 'Attendance Data Loaded';
          });
        } else {
          setState(() {
            _attendanceStatus = 'No attendance data available';
          });
        }
      } catch (e) {
        setState(() {
          _attendanceStatus = 'Error fetching attendance data: ${e.toString()}';
        });
      }
    } else {
      setState(() {
        _attendanceStatus = 'User not logged in';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'E D U - L I N K',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            onPressed: logout,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: _attendanceStatus == 'Loading...'
              ? const CircularProgressIndicator()
              : _attendanceStatus == 'Attendance Data Loaded'
              ? Container(
            width: 300, // Set the width of the container
            height: 400, // Set the height of the container
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.school,
                  color: Colors.deepPurple,
                  size: 80,
                ),
                const SizedBox(height: 20),
                Text(
                  'Attendance Percentage',
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.deepPurple.shade700,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  '${attendancePercentage?.toStringAsFixed(2)}%',
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Text(
                  'Classes Attended',
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.deepPurple.shade700,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  '$classesAttended',
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Text(
                  'Total Classes',
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.deepPurple.shade700,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  '$totalClasses',
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )
              : Text(
            _attendanceStatus,
            style: const TextStyle(
                fontSize: 20,
                color: Colors.redAccent,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
