import 'package:flutter/material.dart';
import '../utils/style_utils.dart';
import '../utils/app_painters.dart';
import 'home_screen.dart';

class RideCompletionScreen extends StatefulWidget {
  const RideCompletionScreen({super.key});

  @override
  State<RideCompletionScreen> createState() => _RideCompletionScreenState();
}

class _RideCompletionScreenState extends State<RideCompletionScreen> {
  int _rating = 0;
  final TextEditingController _feedbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          CustomPaint(painter: GridPatternPainter(), size: Size.infinite),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),
                  const Icon(
                    Icons.check_circle,
                    color: AppStyles.metallicYellow,
                    size: 80,
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Ride Completed!',
                    style: AppStyles.headingStyle,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  _buildSummaryCard(),
                  const SizedBox(height: 40),
                  const Text(
                    'Rate your experience',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  _buildRatingStars(),
                  const SizedBox(height: 24),
                  _buildFeedbackField(),
                  const SizedBox(height: 40),
                  _buildSubmitButton(),
                  const SizedBox(height: 8),
                  _buildReportIssue(),
                  _buildInvoiceLink(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppStyles.cardBg.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        children: [
          _buildDetailRow('Final Price', '\$85.50', isBold: true),
          const Divider(color: Colors.white10, height: 30),
          _buildDetailRow('Distance', '12.4 miles'),
          _buildDetailRow('Duration', '28 mins'),
          _buildDetailRow('Ride Type', 'Executive Sedan'),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.white54, fontSize: 14),
          ),
          Text(
            value,
            style: TextStyle(
              color: isBold ? AppStyles.metallicYellow : Colors.white,
              fontSize: isBold ? 18 : 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingStars() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return IconButton(
          onPressed: () => setState(() => _rating = index + 1),
          icon: Icon(
            index < _rating ? Icons.star_rounded : Icons.star_outline_rounded,
            color: AppStyles.metallicYellow,
            size: 40,
          ),
        );
      }),
    );
  }

  Widget _buildFeedbackField() {
    return TextFormField(
      controller: _feedbackController,
      maxLines: 3,
      style: const TextStyle(color: Colors.white),
      decoration: AppStyles.inputDecoration(
        hintText: 'Share your feedback (Optional)',
      ),
    );
  }

  Widget _buildSubmitButton() {
    return GestureDetector(
      onTap: () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
          (route) => false,
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          gradient: AppStyles.primaryGradient,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Text(
          'Submit & Back Home',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildInvoiceLink() {
    return TextButton.icon(
      onPressed: () {},
      icon: const Icon(
        Icons.download_rounded,
        color: AppStyles.metallicYellow,
        size: 18,
      ),
      label: const Text(
        'Download Invoice (PDF)',
        style: TextStyle(color: AppStyles.metallicYellow),
      ),
    );
  }

  Widget _buildReportIssue() {
    return TextButton(
      onPressed: () {},
      child: const Text(
        'Report an Issue',
        style: TextStyle(color: Colors.redAccent, fontSize: 13),
      ),
    );
  }
}
