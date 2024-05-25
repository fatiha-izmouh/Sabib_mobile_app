import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PostAlertPage extends StatefulWidget {
  const PostAlertPage({Key? key}) : super(key: key);

  @override
  _PostAlertPageState createState() => _PostAlertPageState();
}

class _PostAlertPageState extends State<PostAlertPage> {
  final TextEditingController _messageController = TextEditingController();
  bool _isRead = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Alert'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _messageController,
              decoration: InputDecoration(
                labelText: 'Message',
              ),
            ),
            SizedBox(height: 20),
            CheckboxListTile(
              title: Text('Read'),
              value: _isRead,
              onChanged: (bool? value) {
                setState(() {
                  _isRead = value ?? false;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _postAlert(),
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _postAlert() async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      String message = _messageController.text.trim();
      bool isRead = _isRead;
      DateTime timestamp = DateTime.now();

      await FirebaseFirestore.instance.collection('alerts').add({
        'userId': userId,
        'message': message,
        'isRead': isRead,
        'timestamp': timestamp,
        'place': "Garage"
      });

      // Clear text field after posting alert
      _messageController.clear();

      // Show success message or navigate back to previous screen
    } catch (error) {
      // Handle error
    }
  }
}
