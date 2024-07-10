import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'MarksPage.dart';
import 'TeacherProfile.dart';
import 'TeacherScreen.dart';
import 'UploadFIle.dart';

class TeacherHome extends StatefulWidget {
  const TeacherHome({super.key});

  @override
  State<TeacherHome> createState() => _TeacherHomeState();
}

void logout() {
  FirebaseAuth.instance.signOut();
}

class _TeacherHomeState extends State<TeacherHome> {
  int currentIndex = 0;

  double screenHeight = 0;
  double screenWeight = 0;
  Color primary = Color(0xFF2b2d42);

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWeight = MediaQuery.of(context).size.width;

    List<Map<String, dynamic>> navigationItems = [
      {"icon": Icons.home, "text": "Home"},
      {"icon": Icons.circle_notifications, "text": "Circular"},
      {"icon": Icons.person, "text": "Profile"},
    ];

    return Scaffold(

      appBar: AppBar(
        title: Text(
          'E D U - L I N K ',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            onPressed: logout,
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: IndexedStack(
        index: currentIndex,
        children: [Teacher(), Upload(),TeacherProfileScreen()],
      ),
      bottomNavigationBar: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(2, 2),
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(40)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(navigationItems.length, (index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    currentIndex = index;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      navigationItems[index]['icon'],
                      color: index == currentIndex ? primary : Colors.black54,
                      size: index == currentIndex ? 30 : 25,
                    ),
                    SizedBox(height: 4),
                    Text(
                      navigationItems[index]['text'],
                      style: TextStyle(
                        color: index == currentIndex ? primary : Colors.black54,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
