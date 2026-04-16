import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      'pk_test_51SibBWAYHiAsCNy7QgE5gjQkoIBpUiYTt4M9ScpJAb5LCgjsieiqwWmlxFx94UanaXYnwFGUE0WRsvOJRVdKAhta00UaGP34Hi'; // Replace with a real key
  await Stripe.instance.applySettings();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        primaryColor: const Color(0xFFFFD700),
      ),
      home: const SplashScreen(),
    );
  }
}
