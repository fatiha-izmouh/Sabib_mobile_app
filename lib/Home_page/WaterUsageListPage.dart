import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WaterUsageListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Water Usage and ThingSpeak Data'),
      ),
      body: WaterUsageAndThingSpeakList(),
    );
  }
}

class WaterUsageAndThingSpeakList extends StatefulWidget {
  @override
  _WaterUsageAndThingSpeakListState createState() =>
      _WaterUsageAndThingSpeakListState();
}

class _WaterUsageAndThingSpeakListState
    extends State<WaterUsageAndThingSpeakList> {
  late Future<List<dynamic>> _thingSpeakData;

  @override
  void initState() {
    super.initState();
    _thingSpeakData = _fetchThingSpeakData();
  }

  Future<List<dynamic>> _fetchThingSpeakData() async {
    final String apiKey = "FRGKDWHJHKYSJUCC";
    final String url =
        "https://api.thingspeak.com/channels/2457874/feeds.json?api_key=$apiKey&results=5";

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['feeds'];
      } else {
        throw Exception('Failed to load ThingSpeak data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _thingSpeakData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
          return Center(child: Text('No data available'));
        }

        return ListView.builder(
          itemCount: snapshot.data!.length + 1, // Add 1 for the header
          itemBuilder: (context, index) {
            if (index == 0) {
              return ListTile(
                title: Text('Water Usage Data'),
                dense: true,
              );
            }

            var thingSpeakData = snapshot.data![index - 1];
            var consumption = thingSpeakData['field1'];
            var locationId = thingSpeakData['field2'];

            return ListTile(
              title: Text('Location ID: $locationId'),
              subtitle: Text('Consumption: $consumption'),
            );
          },
        );
      },
    );
  }
}
