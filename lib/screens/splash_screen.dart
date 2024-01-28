import 'package:flutter/material.dart';
import 'package:recipe/routes/route.dart';
import 'package:recipe/screens/homepage_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Add a delay to simulate the splash screen
    Future.delayed(const Duration(seconds: 3), () {
      // Navigate to the home screen
      sendRoute(context, RoutesNames.recipescreen , clearstack: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onDoubleTap: (){sendRoute(context, RoutesNames.recipescreen , clearstack: true);},
        child: Center(
          child: Image.network('https://banner2.cleanpng.com/20180702/cr/kisspng-splash-screen-progress-bar-clip-art-5b39d367b6abf6.0385983915305163277482.jpg'),
        ),
      ));
  }
}
