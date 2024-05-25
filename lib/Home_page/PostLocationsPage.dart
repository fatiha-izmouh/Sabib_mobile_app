import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PostLocationsPage extends StatelessWidget {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();

  void _postLocation(BuildContext context, String userId) {
    String address = _addressController.text.trim();
    String type = _typeController.text.trim();

    // Add your Firebase Firestore logic here to post the location data
    FirebaseFirestore.instance.collection('locations').add({
      'userId': userId, // Use the fetched userId
      'address': address,
      'type': type,
    }).then((value) {
      // Successfully posted location
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Location posted successfully')),
      );
      // Clear text fields after posting
      _addressController.clear();
      _typeController.clear();
    }).catchError((error) {
      // Error posting location
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to post location: $error')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text('Post Location'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _addressController,
              decoration: InputDecoration(labelText: 'Address'),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _typeController,
              decoration: InputDecoration(labelText: 'Type'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _postLocation(context, userId),
              child: Text('Post Location'),
            ),
          ],
        ),
      ),
    );
  }
}
