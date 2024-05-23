
import 'package:edu_link/attendance.dart';
import 'package:edu_link/login.dart';
import 'package:edu_link/register.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'attendance',
    routes: {'login': (context) => const MyLogin(),
    'register':(context) => const MyRegister(),
    'attendance':(context) => const MapPage(),
    }
  ));
}