import 'package:edu_link/pages/GetNotes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'MarksGet.dart';
import 'VideoLectures.dart';
import 'checkAttendance.dart';

class Student extends StatefulWidget {
  const Student({Key? key}) : super(key: key);

  @override
  State<Student> createState() => _StudentState();
}

class _StudentState extends State<Student> {
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
              buttonText: 'Notes',
              icon: FontAwesomeIcons.stickyNote,
              color: Colors.blue,
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Notes()));
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
              buttonText: 'Video Lectures',
              icon: FontAwesomeIcons.video,
              color: Colors.orange,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChatBotC()));
              },
              buttonWidth: buttonWidth,
              buttonHeight: buttonHeight,
            ),
            SizedBox(height: 20),
            buildButton(
              buttonText: 'Attendance',
              icon: FontAwesomeIcons.calendarCheck,
              color: Colors.purple,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Attendance()));
              },
              buttonWidth: buttonWidth,
              buttonHeight: buttonHeight,
            ),
            SizedBox(height: 20),
            buildButton(
              buttonText: 'Marks',
              icon: FontAwesomeIcons.bookOpen,
              color: Colors.red,
              onPressed: () {
                MaterialPageRoute(builder: (context) => MarksScreen());
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
