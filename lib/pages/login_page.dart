import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../components/my_button.dart';
import '../components/my_textfield.dart';
import '../services/auth_services.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  const LoginPage({Key? key, required this.onTap}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Login function
  void login() async {
    try {
      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Retrieve user role from Firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection("users")
          .doc(userCredential.user!.email)
          .get();

      // Close the loading dialog
      Navigator.pop(context);

      if (userDoc.exists && userDoc.data() != null) {
        String role = userDoc.get('role');

        // Navigate based on user role
        switch (role) {
          case 'Student':
            Navigator.pushReplacementNamed(context, 'StudentHome');
            break;
          case 'Faculty':
            Navigator.pushReplacementNamed(context, 'TeacherHome');
            break;
          case 'Parent':
            Navigator.pushReplacementNamed(context, 'ParentHome');
            break;
          default:
            displayMessageToUser('User role not found.');
        }
      } else {
        displayMessageToUser('User role not found.');
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      displayMessageToUser(e.message ?? 'An error occurred. Please try again.');
    } catch (e) {
      Navigator.pop(context);
      displayMessageToUser('An error occurred. Please try again.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/register.png',
            fit: BoxFit.cover,
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 90),
                // Logo
                Icon(
                  Icons.person,
                  size: 90,
                  color: Colors.white,
                ),
                const SizedBox(height: 25),
                // App name
                const Text(
                  "E D U - L I N K ",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 50),
                // Email TextField
                MyTextfield(
                  hinttext: "Email",
                  obscuretext: false,
                  controller: emailController,
                ),
                const SizedBox(height: 25),
                // Password TextField
                MyTextfield(
                  hinttext: "Password",
                  obscuretext: true,
                  controller: passwordController,
                ),
                const SizedBox(height: 5),
                // Forgot Password
                GestureDetector(
                  onTap: () {
                    // Implement forgot password functionality
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Forgot Password?",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                // Sign In Button
                MyButton(
                  text: "Login",
                  onTap: login,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: const Text(
                    'Or continue with',
                    style: TextStyle(color: Color.fromRGBO(57, 52, 52, 1)),
                  ),
                ),
                const SizedBox(height: 25),
                // Google and Apple sign-in buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => AuthServices().signInWithGoogle(context),
                      child: Image.asset('assets/google.png', width: 50),
                    ),
                    const SizedBox(width: 25),
                    GestureDetector(
                      onTap: () {
                        // Implement Apple sign-in logic here
                      },
                      child: Image.asset('assets/apple.png', width: 50),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                // Don't have an account? Register here
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account? "),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        "Register here",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper function to display messages
  void displayMessageToUser(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
