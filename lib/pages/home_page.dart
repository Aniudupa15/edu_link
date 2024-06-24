import 'dart:ui';

import 'package:edu_link/components/my_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  void logout() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HOMEPAGE"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
        actions: [IconButton(onPressed: logout, icon: Icon(Icons.logout))],
      ),
      

      //bottom navbar

      bottomNavigationBar: Container(
        color: const Color.fromARGB(255, 255, 246, 246),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
          child: GNav(
            backgroundColor: Color.fromARGB(255, 118, 110, 110),
            activeColor: Colors.white,
            tabBackgroundColor: Color.fromARGB(255, 53, 52, 52),
            gap: 8,
            padding: EdgeInsets.all(16),
            tabs: [
              GButton(
                icon: Icons.home,
                text: 'Home',
                ),
              GButton(
                icon: Icons.favorite_border,
                text: 'fav',
                ),
              GButton(
                icon: Icons.search,
                text: 'Search',
                ),
              GButton(
                icon: Icons.logout,
                text: 'Logout',
                
              ),
          
          
          
              
          
            ],
          ),
        ),
      ),
    );
  }
}
