import 'package:flutter/material.dart';
import 'package:sabib_feecra/homescreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SelectFloorsScreen extends StatefulWidget {
  @override
  _SelectFloorsScreenState createState() => _SelectFloorsScreenState();
}

class _SelectFloorsScreenState extends State<SelectFloorsScreen> {
  int _selectedFloors = 1;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _incrementFloors() {
    setState(() {
      _selectedFloors++;
    });
  }

  void _decrementFloors() {
    if (_selectedFloors > 1) {
      setState(() {
        _selectedFloors--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set main background color to white
      body: Center(
        child: Container(
          color: Color.fromRGBO(37, 150, 190, 1), // Main background color
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 40.0),
                  child: Text(
                    'How many floors are there?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Text color
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: _decrementFloors,
                      color: Colors.white,
                    ),
                    SizedBox(width: 10),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Text(
                          _selectedFloors.toString(),
                          style: TextStyle(
                              fontSize: 20,
                              color: Color.fromRGBO(37, 150, 190, 1)),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: _incrementFloors,
                      color: Colors.white,
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _selectedFloors = 1;
                        });
                      },
                      child: Text("1"),
                      style: ElevatedButton.styleFrom().copyWith(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white)),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _selectedFloors = 4;
                        });
                      },
                      child: Text("4"),
                      style: ElevatedButton.styleFrom().copyWith(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white)),
                    ),
                  ],
                ),
                Expanded(child: SizedBox()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      color: Colors.white,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        saveNumberOfFloors();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Home()),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Next',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      style: ElevatedButton.styleFrom().copyWith(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void saveNumberOfFloors() async {
    try {
      String userId = _auth.currentUser!.uid;

      await _firestore.collection('locations').doc(userId).update({
        'floors': _selectedFloors,
      });
    } catch (error) {
      print('Error saving number of floors: $error');
    }
  }
}
