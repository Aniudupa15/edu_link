import 'package:edu_link/auth/login_or_register.dart';
import 'package:edu_link/auth/auth.dart'; // Ensure you import Authpage
import 'package:edu_link/pages/TEACHER/MarksPage.dart';
import 'package:edu_link/pages/ParentHome.dart';
import 'package:edu_link/pages/TEACHER/TeacherHome.dart';
import 'package:edu_link/pages/STUDENT/StudentHome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:edu_link/services/firebase_options.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

import 'pages/STUDENT/attendance.dart';
import 'components/consts.dart';
void main() async {
  Gemini.init(apiKey: GEMINI_API_KEY);
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase with the options from firebase_options.dart
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      'attendance':(context) => const MapPage(),
      'MarksPage':(context) => Marks(),
    },
  ));
}