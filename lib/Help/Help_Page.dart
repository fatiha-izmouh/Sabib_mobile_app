import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'AutrePage.dart';
import 'detailsPage.dart';
import '../models/notch_bottom_bar_controller.dart';

class Page3 extends StatefulWidget {
  final NotchBottomBarController? controller;

  const Page3({Key? key, this.controller}) : super(key: key);

  @override
  _Page3State createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  final List<String> problems = [
    "Dysfonctionnement du dispositif",
    "consultation de site",
    "A propos du compte",
    "Autre",
  ];

  final Map<String, List<String>> problemDetails = {
    "Dysfonctionnement du dispositif": ["Détail 1", "Détail 2", "Détail 3"],
    "Besoin d'un plombier": ["Détail 4", "Détail 5", "Détail 6"],
    "A propos du compte": ["Détail 7", "Détail 8", "Détail 9"],
    "Autre": ["Détail 10", "Détail 11", "Détail 12"],
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView.builder(
        itemCount: problems.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(problems[index]),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                if (problems[index] == "Autre") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AutreProblemPage(),
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProblemDetailsPage(
                        problem: problems[index],
                        details: problemDetails[problems[index]] ?? [],
                      ),
                    ),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
