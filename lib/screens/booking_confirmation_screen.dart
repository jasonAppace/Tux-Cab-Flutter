import 'package:flutter/material.dart';
import '../utils/style_utils.dart';

import 'home_screen.dart';
import 'active_ride_details_screen.dart';

class BookingConfirmationScreen extends StatelessWidget {
  const BookingConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.check_circle_rounded,
                color: AppStyles.metallicYellow,
                size: 80,
              ),
              const SizedBox(height: 24),
              const Text(
                'Booking Confirmed!',
                style: AppStyles.headingStyle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'Your ride has been successfully scheduled.',
                style: TextStyle(color: Colors.white54, fontSize: 14),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A1A),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white10),
                ),
                child: Column(
                  children: [
                    _buildSummaryItem('Booking ID', '#TX-99821'),
                    const Divider(color: Colors.white10, height: 24),
                    _buildSummaryItem('Pickup Date', 'Oct 24, 2024'),
                    _buildSummaryItem('Pickup Time', '10:30 AM'),
                    const Divider(color: Colors.white10, height: 24),
                    _buildSummaryItem('Car Category', 'Executive Sedan'),
                    _buildSummaryItem('Estimated Fare', '\$85.50'),
                    const Divider(color: Colors.white10, height: 24),
                    _buildSummaryItem(
                      'Booking Status',
                      'Pending Assignment',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 48),
              _buildActionButton(
                context,
                'View Booking Details',
                true,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ActiveRideDetailsScreen(),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _buildActionButton(
                context,
                'Back to Home',
                false,
                () => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                  (route) => false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
          Text(
            value,
            style: const TextStyle(
              color: AppStyles.metallicYellow,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    String text,
    bool isPrimary,
    VoidCallback onPressed,
  ) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          gradient: isPrimary ? AppStyles.primaryGradient : null,
          color: isPrimary ? null : AppStyles.cardBg.withOpacity(0.5),
          borderRadius: BorderRadius.circular(12),
          border: isPrimary ? null : Border.all(color: Colors.white10),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isPrimary ? Colors.black : Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
