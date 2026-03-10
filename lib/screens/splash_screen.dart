import 'package:flutter/material.dart';
import 'option_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to option screen after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const OptionScreen(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Metallic yellow/gold color matching the logo
    const Color metallicYellow = Color(0xFFFFD700); // Gold color matching the logo
    
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Splash image centered
            Image.asset(
              'assets/images/splash.png',
              fit: BoxFit.contain,
              width: 300,
              height: 300,
            ),
            const SizedBox(height: 0),
            // Tagline
            const Text(
              'Luxury Pre-Scheduled Rides',
              style: TextStyle(
                color: metallicYellow,
                fontSize: 18,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 8),
            // Location
            const Text(
              'Greater Sacramento Area',
              style: TextStyle(
                color: metallicYellow,
                fontSize: 16,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
