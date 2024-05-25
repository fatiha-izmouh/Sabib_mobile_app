import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              _buildLeakSection(context),
              SizedBox(height: 20),
              _buildActivityLogSection(context),
              SizedBox(height: 20),
              _buildLeakListSection(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLeakSection(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('alerts')
          .where('userId', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
          .orderBy('timestamp', descending: true)
          .limit(1)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
          return SizedBox(); // Return empty space if there are no alerts
        }

        var lastAlert =
            snapshot.data!.docs.first.data() as Map<String, dynamic>;

        return GestureDetector(
          onTap: () {
            // Handle leak section tap
          },
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.deepOrangeAccent,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                Icon(Icons.add_alert, size: 40, color: Colors.white),
                SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lastAlert['message'],
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text(
                      lastAlert['place'],
                      style: TextStyle(fontSize: 16, color: Colors.indigo),
                    ),
                  ],
                ),
                Spacer(),
                Text(
                  _calculateTimeAgo(lastAlert['timestamp'].toDate()),
                  style: TextStyle(fontSize: 14, color: Colors.indigo),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildActivityLogSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Activity log",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        _buildFilterDropdown(context),
      ],
    );
  }

  Widget _buildFilterDropdown(BuildContext context) {
    return DropdownButton<String>(
      value: "All", // Initial value
      onChanged: (String? newValue) {
        // Handle filter change
      },
      items: <String>['All', 'Option 1', 'Option 2', 'Option 3']
          .map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: TextStyle(fontSize: 16),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildLeakListSection(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('alerts')
          .where('userId', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        var alerts = snapshot.data!.docs;

        if (alerts.isEmpty) {
          return Center(child: Text('No alerts found'));
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: alerts.length,
          itemBuilder: (context, index) {
            var alert = alerts[index].data() as Map<String, dynamic>;
            return _buildLeakListItem(context, alert, index == 0);
          },
        );
      },
    );
  }

  Widget _buildLeakListItem(
      BuildContext context, Map<String, dynamic> alert, bool isLast) {
    Color backgroundColor =
        isLast ? Colors.deepOrangeAccent : Colors.grey.shade300;
    IconData icon = isLast ? Icons.add_alert : Icons.add_alert_sharp;
    String timeAgo = _calculateTimeAgo(alert['timestamp'].toDate());

    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icon, size: 30, color: Colors.black),
          SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                alert['message'],
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                alert['place'],
                style: TextStyle(fontSize: 14, color: Colors.indigo),
              ),
              SizedBox(height: 5),
              Text(
                timeAgo,
                style: TextStyle(fontSize: 12, color: Colors.indigo),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _calculateTimeAgo(DateTime dateTime) {
    // Calculate time difference
    Duration difference = DateTime.now().difference(dateTime);

    // Format time ago
    if (difference.inSeconds < 60) {
      return "${difference.inSeconds} seconds ago";
    } else if (difference.inMinutes < 60) {
      return "${difference.inMinutes} minutes ago";
    } else if (difference.inHours < 24) {
      return "${difference.inHours} hours ago";
    } else {
      return "${difference.inDays} days ago";
    }
  }
}
