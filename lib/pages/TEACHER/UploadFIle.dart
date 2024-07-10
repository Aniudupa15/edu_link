import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as path;
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore

class Upload extends StatefulWidget {
  const Upload({Key? key}) : super(key: key);

  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  String imageUrl = '';
  String pdfUrl = '';

  Future<void> uploadFile(File file, FileType fileType) async {
    try {
      var firebaseStorageRef;
      if (fileType == FileType.image) {
        firebaseStorageRef =
            FirebaseStorage.instance.ref().child('images/${path.basename(file.path)}');
      } else if (fileType == FileType.custom && path.extension(file.path) == '.pdf') {
        firebaseStorageRef =
            FirebaseStorage.instance.ref().child('pdfs/${path.basename(file.path)}');
      } else {
        return; // Unsupported file type
      }

      var uploadTask = firebaseStorageRef.putFile(file);
      await uploadTask.whenComplete(() async {
        if (fileType == FileType.image) {
          imageUrl = await firebaseStorageRef.getDownloadURL();
        } else if (fileType == FileType.custom && path.extension(file.path) == '.pdf') {
          pdfUrl = await firebaseStorageRef.getDownloadURL();

          // Save the PDF URL to Firestore
          await FirebaseFirestore.instance
              .collection('pdfs') // Replace with your collection name
              .doc('latest') // Replace with your document ID
              .set({'url': pdfUrl});
        }
        setState(() {});
      });
    } catch (e) {
      print('Error uploading file: $e');
    }
  }

  void logout() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () async {
              var file = await ImagePicker().pickImage(source: ImageSource.gallery);
              if (file != null) {
                await uploadFile(File(file.path), FileType.image);
              }
            },
            child: const Icon(Icons.image),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles(
                type: FileType.custom,
                allowedExtensions: ['pdf'],
              );
              if (result != null && result.files.isNotEmpty) {
                PlatformFile file = result.files.first;
                await uploadFile(File(file.path!), FileType.custom);
              }
            },
            child: const Icon(Icons.file_present),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            imageUrl.isEmpty
                ? const Text('No image uploaded.')
                : Image.network(imageUrl),
            const SizedBox(height: 16),
            pdfUrl.isEmpty
                ? const Text('No PDF uploaded.')
                : ElevatedButton(
              onPressed: () {
                // Open PDF logic here
                print('Open PDF: $pdfUrl');
              },
              child: const Text('Open PDF'),
            ),
          ],
        ),
      ),
    );
  }
}