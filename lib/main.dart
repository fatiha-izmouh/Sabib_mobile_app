import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sabib_feecra/Alert/Alert_Page.dart';
import 'package:sabib_feecra/Alert/PostAlertPage.dart';
import 'package:sabib_feecra/Home_page/PostLocationsPage.dart';
import 'package:sabib_feecra/homescreen.dart';
import 'login_signup/Screens/login/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: 'AIzaSyBMTws-BXuUeZZuTgcdD3IWg06vfNOjQn0',
      projectId: 'sabibfeecra',
      storageBucket: 'sabibfeecra.appspot.com',
      messagingSenderId: '350021719608',
      appId: '1:350021719608:android:0449002bae5edd281ab8cd',
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Sabib',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, AsyncSnapshot<User?> snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              return Home();
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return LoginScreen();
          },
        ));
  }
}
