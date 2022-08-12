import 'package:flutter/material.dart';
import 'package:test_demo/homepage.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

class AnimateSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      navigateRoute: Homepage(),
      duration: 6000,
      imageSize: 180,
      imageSrc: "images/MLH_Logo.png",
      text: "Welcome to MLH App",
      textType: TextType.TyperAnimatedText,
      textStyle: TextStyle(
        fontSize: 25.0,
        fontWeight: FontWeight.bold,
        color: Colors.lightBlue[900],
        backgroundColor: Colors.blue.shade50,
      ),
      backgroundColor: Colors.white,
      pageRouteTransition: PageRouteTransition.SlideTransition,
    );
  }
}
