// curved_navigation_bar.dart
import 'package:flutter/material.dart';

class CurvedNavigationBar extends StatefulWidget {
  const CurvedNavigationBar({
    Key? key,
    required this.index,
    required this.onTap,
  }) : super(key: key);

  final int index;
  final Function(int) onTap;

  @override
  _CurvedNavigationBarState createState() => _CurvedNavigationBarState();
}

class _CurvedNavigationBarState extends State<CurvedNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70, // Adjust the height as needed
      decoration: BoxDecoration(
        color: Color(0xFF2633C5), // Set your desired background color
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          buildNavItem(Icons.home, 0),
          buildNavItem(Icons.warning, 1),
          buildNavItem(Icons.add, 2),
          buildNavItem(Icons.stacked_bar_chart, 3),
          buildNavItem(Icons.thermostat, 4),
        ],
      ),
    );
  }

  Widget buildNavItem(IconData icon, int index) {
    return IconButton(
      onPressed: () => widget.onTap(index),
      icon: Icon(icon, size: 30, color: widget.index == index ? Colors  .white : Colors.grey),
    );
  }
}
