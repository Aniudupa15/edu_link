import 'package:flutter/material.dart';
import 'package:edu_link/pages/Login_page.dart';
import 'package:edu_link/pages/register_page.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister>
    with SingleTickerProviderStateMixin {
  // initially show login page
  bool showloginpage = true;

  //reg/log

  void togglepage() {
    setState(() {
      showloginpage = !showloginpage;
    });
    
  }

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (showloginpage) {
      return LoginPage(onTap: togglepage);
    } else {
      return RegisterPage(onTap: togglepage);
    }
  }
}
