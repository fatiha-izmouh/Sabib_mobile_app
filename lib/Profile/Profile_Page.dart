import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../login_signup/Screens/login/login.dart';
import '../models/notch_bottom_bar_controller.dart';
import 'account_settings/AddPaymentMethodScreen.dart';
import 'account_settings/ChangePasswordScreen.dart';
import 'account_settings/EditProfileScreen.dart';

class Page4 extends StatelessWidget {
  final NotchBottomBarController? controller;

  const Page4({Key? key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.grey[300],
                    child: Text(
                      FirebaseAuth.instance.currentUser?.displayName?[0] ?? '',
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    FirebaseAuth.instance.currentUser?.displayName ?? 'User',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            _buildSectionTitle('Account Settings'),
            _buildAccountOption(context, 'Edit Profile', () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditProfileScreen()),
              );
            }),
            _buildAccountOption(context, 'Change Password', () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChangePasswordScreen()),
              );
            }),
            _buildAccountOption(context, 'Add Payment Method', () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddPaymentMethodScreen()),
              );
            }),
            _buildAccountOption(context, 'Log out', () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => LoginScreen()),
              );
            }),
            SizedBox(height: 20),
            _buildSectionTitle('App Settings'),
            _buildAppSettingOption(context, 'Push Notifications'),
            _buildAppSettingOption(context, 'Dark Mode'),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildAccountOption(
      BuildContext context, String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: Colors.grey[300] ?? Colors.grey)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 16),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 18,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppSettingOption(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16),
          ),
          Switch(
            value: false, // Provide the current value of the setting
            onChanged: (value) {
              // Handle app setting change
              // You can update app settings like push notifications or dark mode
            },
          ),
        ],
      ),
    );
  }
}
