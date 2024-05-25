import 'package:flutter/material.dart';

class AutreProblemPage extends StatefulWidget {
  @override
  _AutreProblemPageState createState() => _AutreProblemPageState();
}

class _AutreProblemPageState extends State<AutreProblemPage> {
  TextEditingController _problemController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBar(
          titleSpacing: 0.0,
          title: Row(
            children: [
              Text(
                'Autre Problème',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                'assets/images/sabib.png',
                height: MediaQuery.of(context).size.height * 0.2,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Veuillez entrer votre problème :',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _problemController,
              decoration: InputDecoration(
                labelText: 'Entrez votre problème ici',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  String problem = _problemController.text;
                  print('Problème soumis : $problem');
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: Text(
                    'Envoyer',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
