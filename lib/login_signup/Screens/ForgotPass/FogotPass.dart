import 'package:flutter/material.dart';
import 'package:sabib_feecra/login_signup/components/background.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPass extends StatelessWidget {
  final _emailController = TextEditingController();

  Future<void> sendResetPasswordLink(BuildContext context) async {
    try {
      // Send password reset email
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());

      // Show success message or navigate to login screen
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Password reset email sent successfully'),
          backgroundColor: Colors.green,
        ),
      );

      // You can navigate the user to the login screen or any other screen here
      // Navigator.pushReplacementNamed(context, '/login');
    } on FirebaseAuthException catch (e) {
      // Handle exceptions
      print(e.code);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.message}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Background(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Text(
                          "FORGOT PASSWORD",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff132137),
                            fontSize: 30,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: size.height * 0.03),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(horizontal: 40),
                        child: TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: "Enter your email",
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.05),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 10,
                        ),
                        child: MaterialButton(
                          onPressed: () {
                            final trimmedEmail = _emailController.text.trim();
                            if (isValidEmail(trimmedEmail)) {
                              sendResetPasswordLink(context);
                            } else {
                              // Show a Snackbar with an error message
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Invalid email format'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                          color: Color(0xff132137),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80.0),
                          ),
                          padding: EdgeInsets.all(0),
                          child: Container(
                            alignment: Alignment.center,
                            height: 50.0,
                            width: size.width * 0.8,
                            padding: EdgeInsets.all(0),
                            child: Text(
                              "SEND",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 10,
              left: 10,
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegex.hasMatch(email);
  }
}