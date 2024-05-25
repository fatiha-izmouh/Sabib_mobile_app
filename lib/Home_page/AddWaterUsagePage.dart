import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddWaterUsagePage extends StatefulWidget {
  @override
  _AddWaterUsagePageState createState() => _AddWaterUsagePageState();
}

class _AddWaterUsagePageState extends State<AddWaterUsagePage> {
  final TextEditingController _consumptionController = TextEditingController();

  void _addWaterUsage(BuildContext context) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    String locationId = "your_location_id"; // Set your location ID here
    double consumption = double.tryParse(_consumptionController.text) ?? 0.0;

    try {
      await FirebaseFirestore.instance.collection('waterUsage').add({
        'userId': userId,
        'locationId': locationId,
        'date': Timestamp.now(), // Current date/time
        'consumption': consumption,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Water usage added successfully')),
      );

      // Clear the text field after adding usage
      _consumptionController.clear();
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add water usage: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Water Usage'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _consumptionController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Consumption'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _addWaterUsage(context),
              child: Text('Add Water Usage'),
            ),
          ],
        ),
      ),
    );
  }
}
