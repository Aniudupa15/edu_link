import 'package:edu_link/pages/home.dart';
import 'package:edu_link/auth/login_or_register.dart';
import 'package:edu_link/auth/auth.dart'; // Ensure you import Authpage
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:edu_link/firebase_options.dart';
//hello
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
    },
  ));
}