import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sabib_feecra/login_signup/Screens/login/login.dart';

class NavDrawer extends StatefulWidget {
  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  late User _user; // to store the user info
  @override

  void initState(){
    super.initState();
    //fetch the current user when the widget is initialized
    _user = FirebaseAuth.instance.currentUser!;
  }

  Widget build(BuildContext context) {
    return Drawer(
      child: new ListView(
        children: <Widget>[
          new UserAccountsDrawerHeader(
            accountName: new Text(""),
            accountEmail: new Text(_user.email ?? ""),
            decoration: new BoxDecoration(
              // image: new DecorationImage(
              //   image: new ExactAssetImage('assets/images/sabib.png'),
              //   fit: BoxFit.cover,
              // ),
              color: Color.fromARGB(255, 60, 108, 240),
            ),
            currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://server-avatar.nimostatic.tv/1629531366699/202310051696476684960_1629531366699_avatar.png")),
          ),
          new ListTile(
              leading: Icon(Icons.home),
              title: new Text("Home"),
              onTap: () {
                Navigator.pop(context);
              }),
          new ListTile(
              leading: Icon(Icons.warning_rounded),
              title: new Text("Alert"),
              onTap: () {
                Navigator.pop(context);
              }),
          new ListTile(
              leading: Icon(Icons.stacked_bar_chart),
              title: new Text("Statics"),
              onTap: () {
                Navigator.pop(context);
              }),
          new ListTile(
              leading: Icon(Icons.device_thermostat),
              title: new Text("Quality"),
              onTap: () {
                Navigator.pop(context);
              }),
          new ListTile(
              leading: Icon(Icons.dashboard),
              title: new Text("Docs"),
              onTap: () {
                Navigator.pop(context);
              }),
          new ListTile(
              leading: Icon(Icons.settings),
              title: new Text("Settings"),
              onTap: () {
                Navigator.pop(context);
              }),
          new Divider(),
          new ListTile(
              leading: Icon(Icons.info),
              title: new Text("About"),
              onTap: () {
                Navigator.pop(context);
              }),
          new ListTile(
            leading: Icon(Icons.power_settings_new),
            title: new Text("Logout"),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
