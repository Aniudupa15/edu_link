import 'package:edu_link/auth/login_or_register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../pages/ParentHome.dart';
import '../pages/TeacherHome.dart';
import '../pages/studentHome.dart';

class Authpage extends StatelessWidget {
  const Authpage({super.key});

  Future<Widget> getUserHomePage(User? user) async {
    if (user == null) {
      return const LoginOrRegister();
    }

    try {
      DocumentSnapshot userRoleDoc = await FirebaseFirestore.instance
          .collection('userRoles')
          .doc(user.uid)
          .get();
      String role = userRoleDoc['role'];

      if (role == 'teacher') {
        return const TeacherHome();
      } else if (role == 'student') {
        return const StudentHome();
      } else if (role == 'parent') {
        return const ParentHome();
      } else {
        return const LoginOrRegister();
      }
    } catch (e) {
      print('Error fetching user role: $e');
      return const LoginOrRegister();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            return FutureBuilder<Widget>(
              future: getUserHomePage(snapshot.data),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return const Center(child: Text('Error fetching user role'));
                }
                return snapshot.data!;
              },
            );
          } else {
            return const LoginOrRegister();
          }
        },
      ),
    );
  }
}
