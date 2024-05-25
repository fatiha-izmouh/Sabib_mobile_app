import 'package:flutter/material.dart';

class WelcomeView extends StatelessWidget {
  final AnimationController animationController;

  const WelcomeView({Key? key, required this.animationController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _firstHalfAnimation =
    Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0)).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(
          0.6,
          0.8,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );
    final _secondHalfAnimation =
    Tween<Offset>(begin: Offset(0, 0), end: Offset(-1, 0)).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(
          0.8,
          1.0,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );

    final _welcomeFirstHalfAnimation =
    Tween<Offset>(begin: Offset(2, 0), end: Offset(0, 0)).animate(
        CurvedAnimation(
          parent: animationController,
          curve: Interval(
            0.6,
            0.8,
            curve: Curves.fastOutSlowIn,
          ),
        ));

    final _welcomeImageAnimation =
    Tween<Offset>(begin: Offset(4, 0), end: Offset(0, 0)).animate(
        CurvedAnimation(
          parent: animationController,
          curve: Interval(
            0.6,
            0.8,
            curve: Curves.fastOutSlowIn,
          ),
        ));
    return SlideTransition(
      position: _firstHalfAnimation,
      child: SlideTransition(
        position: _secondHalfAnimation,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SlideTransition(
                position: _welcomeImageAnimation,
                child: Container(
                  constraints: BoxConstraints(maxWidth: 250, maxHeight: 250),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10.0,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/introduction_animation/welcome.jpeg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SlideTransition(
                position: _welcomeFirstHalfAnimation,
                child: Center(
                  child: Text(
                    "Welcome to Sabib\nYour Digital Water Companion",
                    style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(
                padding:
                EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Text(
                  "Step into a world where technology meets sustainability. Sabib is here to guide you on a journey of water conservation, real-time monitoring, and effortless control. Begin your seamless experience today and empower yourself with the tools to make a difference",
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}