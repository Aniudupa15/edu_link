import 'package:edu_link/auth/login_or_register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../pages/ParentHome.dart';
import '../pages/TeacherHome.dart';
import '../pages/StudentHome.dart';

class Authpage extends StatelessWidget {
  const Authpage({Key? key});

  Future<String> getUserRole(String userEmail) async {
    try {
      DocumentSnapshot userRoleDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userEmail)
          .get();
      return userRoleDoc['role'];
    } catch (e) {
      print('Error fetching user role: $e');
      return '';
    }
  }

  Future<Widget> getUserHomePage(User? user) async {
    if (user == null) {
      return const LoginOrRegister();
    }

    String role = await getUserRole(user.email!);

    switch (role) {
      case 'Teacher':
        return const TeacherHome();
      case 'Student':
        return const StudentHome();
      case 'Parent':
        return const ParentHome();
      default:
        return const LoginOrRegister();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return FutureBuilder<Widget>(
              future: getUserHomePage(snapshot.data),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return const Center(child: Text('Error fetching user role'));
                }
                return snapshot.data ?? const LoginOrRegister();
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
