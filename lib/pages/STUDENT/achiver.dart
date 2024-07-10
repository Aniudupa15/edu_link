import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'package:dio/dio.dart'; // Import for downloading files
import 'package:path_provider/path_provider.dart'; // Import for getting the device's local path
import 'package:path/path.dart' as path; // Import for manipulating file paths
import 'dart:io'; // Import for file operations

class Achiver extends StatefulWidget {
  const Achiver({Key? key}) : super(key: key);

  @override
  State<Achiver> createState() => _AchiverState();
}

void logout() {
  FirebaseAuth.instance.signOut();
}

class _AchiverState extends State<Achiver> {
  String pdfUrl = ''; // Add a variable to store the PDF URL
  bool isLoading = true; // Add a loading indicator
  bool isDownloading = false; // Add a downloading indicator

  @override
  void initState() {
    super.initState();
    fetchPdfUrl();
  }

  Future<void> fetchPdfUrl() async {
    try {
      // Assume the PDF URL is stored in a document in Firestore
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await FirebaseFirestore.instance
          .collection('pdfs') // Replace with your collection name
          .doc('latest') // Replace with your document ID
          .get();

      if (documentSnapshot.exists) {
        setState(() {
          pdfUrl = documentSnapshot.data()?['url'] ?? '';
        });
      } else {
        setState(() {
          pdfUrl = '';
        });
      }
    } catch (e) {
      print('Error fetching PDF URL: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> downloadPdf(String url) async {
    setState(() {
      isDownloading = true;
    });

    try {
      // Get the external storage directory
      var dir = await getExternalStorageDirectory();
      if (dir != null) {
        var filePath = path.join(dir.path, 'downloaded.pdf'); // The path where the file will be saved

        // Download the file using Dio
        Dio dio = Dio();
        await dio.download(url, filePath);

        // Show a message when the download is complete
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('PDF downloaded to $filePath')));
        print('PDF downloaded to $filePath');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Could not find external storage directory')));
      }
    } catch (e) {
      print('Error downloading PDF: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error downloading PDF')));
    } finally {
      setState(() {
        isDownloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Student Dashboard',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            isLoading
                ? CircularProgressIndicator()
                : pdfUrl.isEmpty
                ? const Text('No PDF available.')
                : ElevatedButton(
              onPressed: isDownloading
                  ? null
                  : () async {
                await downloadPdf(pdfUrl);
              },
              child: isDownloading ? CircularProgressIndicator() : const Text('View/Download PDF'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Student App',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: const Achiver(),
  ));
}