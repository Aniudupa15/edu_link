import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TeacherHome extends StatefulWidget {
  const TeacherHome({super.key});

  @override
  State<TeacherHome> createState() => _TeacherHomeState();
}
void logout(){
  FirebaseAuth.instance.signOut();
}
class _TeacherHomeState extends State<TeacherHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('E D U - A I ',style: TextStyle(color: Colors.white,fontSize: 20),),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
              onPressed: logout,
              icon: Icon(Icons.logout)),
        ],
      ),
      body: Text('Teacher Dashboard'),
    );
  }
}
