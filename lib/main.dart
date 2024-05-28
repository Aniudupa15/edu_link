import 'package:edu_link/admin.dart';
import 'package:edu_link/attendance.dart';
import 'package:edu_link/home/home.dart';
import 'package:edu_link/login.dart';
import 'package:edu_link/register.dart';
import 'package:edu_link/user.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      routes: {
        'login': (context) => const MyLogin(),
        'register': (context) => const MyRegister(),
        'attendance': (context) => const MapPage(),
        // 'user': (context) => const Myuser(),
        // 'admin': (context) => const Myadmin(),
        'home': (context) => HomeScreen(),
      }));
}
