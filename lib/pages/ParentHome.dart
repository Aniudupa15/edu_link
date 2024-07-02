import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ParentHome extends StatefulWidget {
  const ParentHome({super.key});

  @override
  State<ParentHome> createState() => _ParentHomeState();
}
void logout(){
  FirebaseAuth.instance.signOut();
}
class _ParentHomeState extends State<ParentHome> {
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
      body: Text('Parent Dashboard'),
    );
  }
}
