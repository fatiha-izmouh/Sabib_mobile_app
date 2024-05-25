import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sabib_feecra/homescreen.dart'; // Import your Home screen file

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    // Set initial values for name and email from FirebaseAuth
    final currentUser = FirebaseAuth.instance.currentUser;
    _nameController.text = currentUser?.displayName?.split(' ')[0] ?? '';
    _surnameController.text = currentUser?.displayName?.split(' ')[1] ?? '';

    // Fetch phone number from Firestore
    _fetchPhoneNumber(currentUser?.uid);
  }

  Future<void> _fetchPhoneNumber(String? uid) async {
    if (uid != null) {
      try {
        final userData =
            await FirebaseFirestore.instance.collection('users').doc(uid).get();
        if (userData.exists) {
          setState(() {
            _phoneNumberController.text = userData['phoneNumber'] ?? '';
          });
        }
      } catch (error) {
        print("Error fetching phone number: $error");
        // Handle error
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Nom'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _surnameController,
                  decoration: InputDecoration(labelText: 'Prenom'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your surname';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _phoneNumberController,
                  decoration: InputDecoration(labelText: 'Numéro de téléphone'),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 50),
                ElevatedButton(
                  onPressed: _isSaving
                      ? null
                      : () {
                          if (_formKey.currentState!.validate()) {
                            _saveChanges(
                                context); // Pass context to _saveChanges
                          }
                        },
                  child: _isSaving
                      ? CircularProgressIndicator()
                      : Text('Save Changes'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _saveChanges(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    setState(() {
      _isSaving = true;
    });
    await user?.updateDisplayName(
        _nameController.text + " " + _surnameController.text);

    // Store user data in Firestore
    FirebaseFirestore.instance.collection('users').doc(user?.uid).set({
      'name': _nameController.text,
      'surname': _surnameController.text,
      'phoneNumber': _phoneNumberController.text,
      'email': user?.email,
      // You should not store passwords in plaintext. This is for demonstration purposes only.
      'password': user?.providerData[0].providerId == 'password'
          ? user?.providerData[0].uid
          : null,
    }).then((value) {
      Navigator.pushReplacement(
        // Replace Navigator.pop with Navigator.pushReplacement
        context,
        MaterialPageRoute(
            builder: (context) =>
                Home()), // Replace Home() with your Home screen
      );
    }).catchError((error) {
      // Handle errors
      print("Error updating user profile: $error");
      // You can display an error message or take other actions as needed
    }).whenComplete(() {
      setState(() {
        _isSaving = false;
      });
    });
  }
}
