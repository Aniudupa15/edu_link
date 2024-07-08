import 'package:flutter/material.dart';
import '../pages/Login_page.dart';
import '../pages/register_page.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister>
    with SingleTickerProviderStateMixin {
  bool showLoginPage = true;

  void togglePage() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: showLoginPage
            ? LoginPage(
          key: const ValueKey('LoginPage'),
          onTap: togglePage,
        )
            : RegisterPage(
          key: const ValueKey('RegisterPage'),
          onTap: togglePage,
        ),
      ),
    );
  }
}
