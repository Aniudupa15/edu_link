import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MarksScreen extends StatefulWidget {
  @override
  _MarksScreenState createState() => _MarksScreenState();
}

void logout() {
  FirebaseAuth.instance.signOut();
}

class _MarksScreenState extends State<MarksScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  Map<String, dynamic>? _marksData;

  Future<void> _fetchMarks() async {
    if (_formKey.currentState!.validate()) {
      String name = _nameController.text;

      try {
        DocumentSnapshot doc = await FirebaseFirestore.instance.collection('students').doc(name).get();
        if (doc.exists) {
          setState(() {
            _marksData = doc['marks'];
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('No data found for this student')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to fetch marks: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildTextField(
                controller: _nameController,
                labelText: 'Student Name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the student name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _fetchMarks,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: TextStyle(fontSize: 18),
                ),
                child: Text('Fetch Marks'),
              ),
              SizedBox(height: 20),
              _marksData != null
                  ? _buildMarksList(_marksData!)
                  : Text('Enter a student name to fetch marks'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required String? Function(String?) validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(),
          filled: true,
          fillColor: Colors.grey[200],
        ),
        validator: validator,
      ),
    );
  }

  Widget _buildMarksList(Map<String, dynamic> marksData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Marks:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        for (var entry in marksData.entries)
          Text('${entry.key}: ${entry.value}', style: TextStyle(fontSize: 16)),
      ],
    );
  }
}
