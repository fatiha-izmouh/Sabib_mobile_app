import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;

  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
              "assets/images/login_signup/top1.png",
              width: size.width
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
              "assets/images/login_signup/top2.png",
              width: size.width
            ),
          ),
          /*Positioned(
            top: 50,
            right: 30,
            child: Image.asset(
              "assets/images/login_signup/main.png",
              width: size.width * 0.35
            ),
          ),*/
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              "assets/images/login_signup/bottom1.png",
              width: size.width
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              "assets/images/login_signup/bottom2.png",
              width: size.width
            ),
          ),
          child
        ],
      ),
    );
  }
}