import 'package:flutter/material.dart';

class ProblemDetailsPage extends StatefulWidget {
  final String problem;
  final List<String> details;

  ProblemDetailsPage({required this.problem, required this.details});

  @override
  _ProblemDetailsPageState createState() => _ProblemDetailsPageState();
}

class _ProblemDetailsPageState extends State<ProblemDetailsPage> {
  List<bool> _selectedDetails = [];

  @override
  void initState() {
    super.initState();
    _selectedDetails = List<bool>.filled(widget.details.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails du Problème'),
      ),
      body: ListView.builder(
        itemCount: widget.details.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(widget.details[index]),
              trailing: Checkbox(
                value: _selectedDetails[index],
                onChanged: (value) {
                  setState(() {
                    _selectedDetails[index] = value ?? false;
                  });
                },
              ),
              onTap: () {
                setState(() {
                  _selectedDetails[index] = !_selectedDetails[index];
                });
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle selected details here
          List<String> selectedDetails = [];
          for (int i = 0; i < widget.details.length; i++) {
            if (_selectedDetails[i]) {
              selectedDetails.add(widget.details[i]);
            }
          }
          // Do something with selected details
          print(selectedDetails);
        },
        child: Icon(Icons.done),
      ),
    );
  }
}
