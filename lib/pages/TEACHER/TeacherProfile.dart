import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TeacherProfileScreen extends StatefulWidget {
  TeacherProfileScreen({Key? key}) : super(key: key);

  final List<String> Semester = ['1', '2', '3', '4', '5', '6', '7', '8'];

  @override
  _TeacherProfileScreenState createState() => _TeacherProfileScreenState();
}

class _TeacherProfileScreenState extends State<TeacherProfileScreen> {
  final User? currentUser = FirebaseAuth.instance.currentUser;

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();

  String? selectedSemester;
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    // Initialize controller values if data is available
    getUserDetails().then((snapshot) {
      if (snapshot.exists) {
        Map<String, dynamic> user = snapshot.data()!;
        setState(() {
          usernameController.text = user['username'];
          emailController.text = user['email'];
          subjectController.text = user['subjects'] ?? '';
          phoneNumberController.text = user['phoneNumber'] ?? '';
          experienceController.text = user['experience'] ?? '';
          selectedSemester = user['semester'] ?? '';
        });
      }
    }).catchError((error) {
      print('Error getting user details: $error');
    });
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
    if (currentUser != null && currentUser!.email != null) {
      return await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUser!.email!) // Use email as document ID
          .get();
    } else {
      throw Exception("User not logged in or email is null");
    }
  }

  Future<void> updateUserDetails() async {
    if (currentUser != null && currentUser!.email != null) {
      await FirebaseFirestore.instance.collection("teachers").doc(currentUser!.email!).update({
        'username': usernameController.text,
        'subjects': subjectController.text,
        'phoneNumber': phoneNumberController.text,
        'experience': experienceController.text,
        'semester': selectedSemester,
      });
    } else {
      throw Exception("User not logged in or email is null");
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    subjectController.dispose();
    phoneNumberController.dispose();
    experienceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teacher Profile'),
      ),
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: getUserDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          } else if (snapshot.hasData && snapshot.data!.exists) {
            Map<String, dynamic>? user = snapshot.data!.data();
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  TextField(
                    controller: usernameController,
                    decoration: InputDecoration(labelText: 'Username'),
                    readOnly: !isEditing,
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(labelText: 'Email'),
                    readOnly: true,
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: subjectController,
                    decoration: InputDecoration(labelText: 'Subjects'),
                    readOnly: !isEditing,
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: phoneNumberController,
                    decoration: InputDecoration(labelText: 'Phone Number'),
                    readOnly: !isEditing,
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: experienceController,
                    decoration: InputDecoration(labelText: 'Experience'),
                    readOnly: !isEditing,
                  ),
                  SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: selectedSemester?.isNotEmpty == true ? selectedSemester : null,
                    items: widget.Semester.map((String semester) {
                      return DropdownMenuItem(
                        value: semester,
                        child: Text('Semester $semester'),
                      );
                    }).toList(),
                    onChanged: isEditing ? (value) => setState(() => selectedSemester = value) : null,
                    decoration: InputDecoration(labelText: 'Semester'),
                  ),
                  SizedBox(height: 20),
                  isEditing
                      ? ElevatedButton(
                    onPressed: () {
                      updateUserDetails();
                      setState(() => isEditing = false);
                    },
                    child: Text('Save Changes'),
                  )
                      : ElevatedButton(
                    onPressed: () {
                      setState(() => isEditing = true);
                    },
                    child: Text('Edit'),
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: Text("No data available"),
            );
          }
        },
      ),
    );
  }
}
