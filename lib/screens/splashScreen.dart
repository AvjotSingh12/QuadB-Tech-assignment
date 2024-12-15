import 'package:flutter/material.dart';
import 'homeScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Initialize animation for scaling effect
    _animationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    )..forward(); // Start animation

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    // Navigate to HomeScreen after a delay
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Dark background
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Scaling logo animation
            ScaleTransition(
              scale: _animation,
              child: Image.asset(
                'assets/images/splashimage.jpg',
                width: 200,
                height: 200,
              ),
            ),
            SizedBox(height: 20),

            // Fade-in text for App name
            FadeTransition(
              opacity: _animation,
              child: Text(
                "Movie World",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.red[900],
                ),
              ),
            ),
            SizedBox(height: 10),

            // Loading text with subtle animation
            FadeTransition(
              opacity: _animation,
              child: Text(
                "Loading...",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  color: Colors.white70,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
