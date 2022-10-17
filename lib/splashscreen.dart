import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:flowers_app/home.dart';

class MySplash extends StatefulWidget {
  @override
  _MySplashState createState() => _MySplashState();
}

class _MySplashState extends State<MySplash> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 5,
      navigateAfterSeconds: Home(),
      title: Text(
          'Flower Identifier',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 40,
            color: Colors.black87,
            fontFamily: "Signatra",
          )
      ),
      image: Image.asset(
        'assets/flowers.png',
      ),
      backgroundColor: Colors.white,
      photoSize: 180,
      loaderColor: Colors.black87,
      loadingText: Text(
        "Developed by Ashaf",
        style: TextStyle(
          color: Colors.black,
          fontSize: 20.0,
          fontFamily: "Signatra",
        ),
      ),
    );
  }
}
