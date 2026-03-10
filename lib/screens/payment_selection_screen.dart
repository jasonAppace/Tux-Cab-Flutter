import 'package:flutter/material.dart';
import '../utils/style_utils.dart';
import '../utils/app_painters.dart';
import 'booking_confirmation_screen.dart';

class PaymentSelectionScreen extends StatefulWidget {
  final double totalAmount;
  const PaymentSelectionScreen({super.key, required this.totalAmount});

  @override
  State<PaymentSelectionScreen> createState() => _PaymentSelectionScreenState();
}

class _PaymentSelectionScreenState extends State<PaymentSelectionScreen> {
  int _selectedCardIndex = 0;

  final List<Map<String, String>> _savedCards = [
    {'type': 'Visa', 'number': '**** **** **** 4242', 'expiry': '12/26'},
    {'type': 'MasterCard', 'number': '**** **** **** 8899', 'expiry': '10/25'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Payment Selection',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          CustomPaint(painter: GridPatternPainter(), size: Size.infinite),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildSectionTitle('Select Saved Card'),
                  const SizedBox(height: 16),
                  ..._savedCards.asMap().entries.map(
                    (entry) => _buildCardItem(entry.key, entry.value),
                  ),
                  const SizedBox(height: 16),
                  _buildAddNewCardButton(),
                  const SizedBox(height: 40),
                  _buildSectionTitle('Billing Summary'),
                  const SizedBox(height: 16),
                  _buildBillingSummary(),
                  const SizedBox(height: 40),
                  _buildSectionTitle('Cancellation Policy'),
                  const SizedBox(height: 12),
                  const Text(
                    '• Free cancellation up to 12 hours before pickup.\n• 50% charge if canceled within 6-12 hours.\n• No refund for cancellations under 6 hours.',
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 13,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 50),
                  _buildPayButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: AppStyles.metallicYellow,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildCardItem(int index, Map<String, String> card) {
    bool isSelected = _selectedCardIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedCardIndex = index),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? AppStyles.metallicYellow.withOpacity(0.1)
              : AppStyles.cardBg.withOpacity(0.3),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppStyles.metallicYellow : Colors.white10,
          ),
        ),
        child: Row(
          children: [
            Icon(
              card['type'] == 'Visa'
                  ? Icons.credit_card
                  : Icons.credit_card_rounded,
              color: isSelected ? AppStyles.metallicYellow : Colors.white70,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    card['number']!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Expires ${card['expiry']}',
                    style: const TextStyle(color: Colors.white54, fontSize: 12),
                  ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(Icons.check_circle, color: AppStyles.metallicYellow),
          ],
        ),
      ),
    );
  }

  Widget _buildAddNewCardButton() {
    return TextButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.add, color: AppStyles.metallicYellow),
      label: const Text(
        'Add New Card',
        style: TextStyle(color: AppStyles.metallicYellow),
      ),
      style: TextButton.styleFrom(alignment: Alignment.centerLeft),
    );
  }

  Widget _buildBillingSummary() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppStyles.cardBg.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        children: [
          _buildSummaryRow(
            'Estimated Fare',
            '\$${widget.totalAmount.toStringAsFixed(2)}',
          ),
          _buildSummaryRow('Booking Fee', '\$2.50'),
          const Divider(color: Colors.white10, height: 24),
          _buildSummaryRow(
            'Total to Pay',
            '\$${(widget.totalAmount + 2.50).toStringAsFixed(2)}',
            isTotal: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: isTotal ? Colors.white : Colors.white54,
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: isTotal ? AppStyles.metallicYellow : Colors.white,
              fontSize: isTotal ? 18 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPayButton() {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const BookingConfirmationScreen(),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          gradient: AppStyles.primaryGradient,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppStyles.metallicYellow.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Text(
          '✔ Pay & Schedule Ride',
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
}
