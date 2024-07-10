import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Marks extends StatefulWidget {
  @override
  _MarksState createState() => _MarksState();
}

void logout() {
  FirebaseAuth.instance.signOut();
}

class _MarksState extends State<Marks> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _subject1Controller = TextEditingController();
  final TextEditingController _subject2Controller = TextEditingController();
  final TextEditingController _subject3Controller = TextEditingController();
  final TextEditingController _subject4Controller = TextEditingController();

  Future<void> _uploadMarks() async {
    if (_formKey.currentState!.validate()) {
      String name = _nameController.text;
      int subject1 = int.parse(_subject1Controller.text);
      int subject2 = int.parse(_subject2Controller.text);
      int subject3 = int.parse(_subject3Controller.text);
      int subject4 = int.parse(_subject4Controller.text);

      try {
        await FirebaseFirestore.instance.collection('students').doc(name).set({
          'name': name,
          'marks': {
            'subject1': subject1,
            'subject2': subject2,
            'subject3': subject3,
            'subject4': subject4,
          },
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Marks uploaded successfully!')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to upload marks: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'E D U - L I N K',
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
              _buildTextField(
                controller: _subject1Controller,
                labelText: 'Subject 1 Marks',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter marks for Subject 1';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              _buildTextField(
                controller: _subject2Controller,
                labelText: 'Subject 2 Marks',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter marks for Subject 2';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              _buildTextField(
                controller: _subject3Controller,
                labelText: 'Subject 3 Marks',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter marks for Subject 3';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              _buildTextField(
                controller: _subject4Controller,
                labelText: 'Subject 4 Marks',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter marks for Subject 4';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _uploadMarks,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: TextStyle(fontSize: 18,color: Colors.white),
                ),
                child: Text('Upload Marks',style: TextStyle(color: Colors.white),),
              ),
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
        keyboardType: TextInputType.number,
        validator: validator,
      ),
    );
  }
}
