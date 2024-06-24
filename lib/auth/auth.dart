import 'package:edu_link/auth/login_or_register.dart';
import 'package:edu_link/home/calendarscreen.dart';
import 'package:edu_link/pages/home.dart';
import 'package:edu_link/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Authpage extends StatelessWidget {
  const Authpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const Homepage();
            } else {
              return const LoginOrRegister();
            }
          }),
    );
  }
}
