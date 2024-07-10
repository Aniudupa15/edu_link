import 'package:edu_link/pages/GetNotes.dart';
import 'package:edu_link/pages/MarksPage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'UploadFIle.dart';
import 'VideoLectures.dart';
import 'checkAttendance.dart';

class Teacher extends StatefulWidget {
  const Teacher({Key? key}) : super(key: key);

  @override
  State<Teacher> createState() => _TeacherState();
}

class _TeacherState extends State<Teacher> {
  @override
  Widget build(BuildContext context) {
    double buttonWidth =
        MediaQuery.of(context).size.width * 0.6; // Adjust as needed
    double buttonHeight = 80.0; // Reduced button height

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildButton(
              buttonText: 'Upload Notes',
              icon: FontAwesomeIcons.stickyNote,
              color: Colors.blue,
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => const Upload()));
              },
              buttonWidth: buttonWidth,
              buttonHeight: buttonHeight,
            ),
            SizedBox(height: 20),
            buildButton(
              buttonText: 'Chat',
              icon: FontAwesomeIcons.comments,
              color: Colors.green,
              onPressed: () {
                // Navigate to chat screen
              },
              buttonWidth: buttonWidth,
              buttonHeight: buttonHeight,
            ),
            SizedBox(height: 20),
            buildButton(
              buttonText: 'Upload Marks',
              icon: FontAwesomeIcons.bookOpen,
              color: Colors.red,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Marks()));
              },
              buttonWidth: buttonWidth,
              buttonHeight: buttonHeight,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButton({
    required String buttonText,
    required IconData icon,
    required Color color,
    required void Function() onPressed,
    required double buttonWidth,
    required double buttonHeight,
  }) {
    return Container(
      width: buttonWidth,
      height: buttonHeight,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        icon: FaIcon(icon, size: 40),
        label: Text(
          buttonText,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
