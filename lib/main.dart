
import 'package:edu_link/auth/login_or_register.dart';
import 'package:edu_link/auth/auth.dart'; // Ensure you import Authpage
import 'package:edu_link/pages/ParentHome.dart';
import 'package:edu_link/pages/TeacherHome.dart';
import 'package:edu_link/pages/StudentHome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:edu_link/services/firebase_options.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'auth',
    routes: {
      'auth': (context) => const Authpage(),
      'ParentHome': (context) => const ParentHome(),
      'StudentHome': (context) => const StudentHome(),
      'TeacherHome': (context) => const TeacherHome(),
    },
  ));
}