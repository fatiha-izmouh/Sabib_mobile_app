import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'LocationDetailsScreen.dart';

class LocationTypeScreen extends StatefulWidget {
  @override
  _LocationTypeScreenState createState() => _LocationTypeScreenState();
}

class _LocationTypeScreenState extends State<LocationTypeScreen> {
  late int _selectedButtonIndex;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _selectedButtonIndex = -1; // Initially, no button is selected
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromRGBO(37, 150, 190, 1), // Main background color
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 40.0),
                child: Text(
                  'What type of location is this?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Text color
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: LocationTypeButton(
                              label: 'House',
                              icon: Icons.house,
                              onTap: () {
                                setState(() {
                                  _selectedButtonIndex = 0;
                                });
                              },
                              isSelected: _selectedButtonIndex == 0,
                            ),
                          ),
                          SizedBox(width: 10.0),
                          Expanded(
                            child: LocationTypeButton(
                              label: 'Apartment',
                              icon: Icons.apartment,
                              onTap: () {
                                setState(() {
                                  _selectedButtonIndex = 1;
                                });
                              },
                              isSelected: _selectedButtonIndex == 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: LocationTypeButton(
                              label: 'Building',
                              icon: Icons.business,
                              onTap: () {
                                setState(() {
                                  _selectedButtonIndex = 2;
                                });
                              },
                              isSelected: _selectedButtonIndex == 2,
                            ),
                          ),
                          SizedBox(width: 10.0),
                          Expanded(
                            child: LocationTypeButton(
                              label: 'Other',
                              icon: Icons.place,
                              onTap: () {
                                setState(() {
                                  _selectedButtonIndex = 3;
                                });
                              },
                              isSelected: _selectedButtonIndex == 3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  saveLocationType();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LocationDetailsScreen(),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Next',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void saveLocationType() async {
    try {
      String userId = _auth.currentUser!.uid;
      String locationType = '';

      switch (_selectedButtonIndex) {
        case 0:
          locationType = 'House';
          break;
        case 1:
          locationType = 'Apartment';
          break;
        case 2:
          locationType = 'Building';
          break;
        case 3:
          locationType = 'Other';
          break;
        default:
          break;
      }

      await _firestore.collection('locations').doc(userId).set({
        'locationType': locationType,
        'userId': userId,
      });
    } catch (error) {
      print('Error saving location type: $error');
    }
  }
}

class LocationTypeButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final bool isSelected;

  const LocationTypeButton({
    required this.label,
    required this.icon,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isSelected ? Colors.blue[800] : Colors.white, // Button color
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 30.0,
                color:
                    isSelected ? Colors.white : Colors.blue[800], // Icon color
              ),
              SizedBox(height: 10.0),
              Text(
                label,
                style: TextStyle(
                  fontSize: 18.0,
                  color: isSelected
                      ? Colors.white
                      : Colors.blue[800], // Text color
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
