import 'package:flutter/material.dart';

class AppStyles {
  // Main metallic yellow/gold color
  static const Color metallicYellow = Color(0xFFFFD700);

  // Dark background colors
  static const Color darkBg = Color(0xFF0D1117);
  static const Color cardBg = Color(0xFF161B22);
  static const Color innerCardBg = Color(0xFF1C2128);
  static const Color inputBg = Color(0xFF0D1117);
  static const Color surfaceBg = Color(0xFF010409);

  // Status colors
  static const Color upcomingBg = Color(0xFF1A3A5A);
  static const Color upcomingText = Color(0xFF58A6FF);
  static const Color assignedBg = Color(0xFF3B3B00);
  static const Color assignedText = Color(0xFFD29922);

  // Button colors
  static const Color primaryButton = Color(0xFFFFD700);
  static const Color secondaryButton = Color(0xFF30363D);

  // Gradient for the primary button (less shining/more subtle)
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [
      Color(0xFFFFD700), // Gold
      Color(0xFFFFC107), // Amber
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Border and shadow styles
  static final Border cardBorder = Border.all(
    color: Colors.white.withOpacity(0.1),
    width: 1.0,
  );

  static const double borderRadius = 16.0;

  // Typography
  static const TextStyle headingStyle = TextStyle(
    color: Colors.white,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle bodyStyle = TextStyle(
    color: Colors.white70,
    fontSize: 14,
  );

  static const TextStyle labelStyle = TextStyle(
    color: Colors.white,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  // Input decorations
  static InputDecoration inputDecoration({
    required String hintText,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(color: Colors.white24, fontSize: 14),
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: const Color(0xFF1A1A1A).withOpacity(0.5),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: metallicYellow, width: 1),
      ),
    );
  }
}
