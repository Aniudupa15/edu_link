import 'package:edu_link/admin.dart';
import 'package:edu_link/attendance.dart';
import 'package:edu_link/auth/auth.dart';
import 'package:edu_link/pages/home.dart';
//import 'package:edu_link/login.dart';
//import 'package:edu_link/register.dart';
import 'package:edu_link/auth/login_or_register.dart';
import 'package:edu_link/user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:edu_link/auth/login_or_register.dart';
import 'package:edu_link/firebase_options.dart';

 


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'auth',
      routes: {
        'login_or_register': (context) => const LoginOrRegister(),
        'auth': (context) => const Authpage(),

        //'login': (context) => const MyLogin(),
        //'register': (context) => const MyRegister(),
        'attendance': (context) => const MapPage(),
        // 'user': (context) => const Myuser(),
        // 'admin': (context) => const Myadmin(),
        'home': (context) => HomeScreen(),
      }));
}
