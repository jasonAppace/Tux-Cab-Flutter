import 'package:flutter/material.dart';
import 'payment_selection_screen.dart';
import '../utils/style_utils.dart';
import '../utils/app_painters.dart';

class PriceBreakdownScreen extends StatelessWidget {
  final String category;
  final bool rideShareEnabled;
  const PriceBreakdownScreen({
    super.key,
    required this.category,
    required this.rideShareEnabled,
  });

  @override
  Widget build(BuildContext context) {
    // Mock values
    double baseFare = category == 'SUV'
        ? 80.0
        : (category == 'Executive Sedan' ? 50.0 : 30.0);
    double distanceCharge = 27.50; // 10 miles * 2.75
    double waitingCharge = 0.0;
    double tax = (baseFare + distanceCharge) * 0.0825; // CA Tax
    double subTotal = baseFare + distanceCharge + waitingCharge + tax;
    double discount = rideShareEnabled ? (subTotal * 0.15) : 0;
    double grandTotal = subTotal - discount;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Price Breakdown',
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
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildFareSummary(
                    baseFare,
                    distanceCharge,
                    waitingCharge,
                    tax,
                    discount,
                    grandTotal,
                  ),
                  const Spacer(),
                  _buildConfirmButton(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFareSummary(
    double base,
    double dist,
    double wait,
    double tax,
    double disc,
    double total,
  ) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppStyles.cardBg.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        children: [
          _buildPriceRow('Base Fare', base),
          _buildPriceRow('Distance Charge (10 mi)', dist),
          _buildPriceRow('Waiting Charge', wait),
          _buildPriceRow('Taxes (California)', tax),
          if (rideShareEnabled)
            _buildPriceRow('RideShare Discount (15%)', -disc, isDiscount: true),
          const Divider(color: Colors.white24, height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Grand Total',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '\$${total.toStringAsFixed(2)}',
                style: const TextStyle(
                  color: AppStyles.metallicYellow,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, double value, {bool isDiscount = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 15),
          ),
          Text(
            '${value < 0 ? "-" : ""}\$${value.abs().toStringAsFixed(2)}',
            style: TextStyle(
              color: isDiscount ? Colors.greenAccent : Colors.white,
              fontSize: 15,
              fontWeight: isDiscount ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmButton(BuildContext context) {
    // Re-calculate grandTotal for the next screen (mock logic)
    double baseFare = category == 'SUV'
        ? 80.0
        : (category == 'Executive Sedan' ? 50.0 : 30.0);
    double distanceCharge = 27.50;
    double tax = (baseFare + distanceCharge) * 0.0825;
    double subTotal = baseFare + distanceCharge + tax;
    double discount = rideShareEnabled ? (subTotal * 0.15) : 0;
    double grandTotal = subTotal - discount;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                PaymentSelectionScreen(totalAmount: grandTotal),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          gradient: AppStyles.primaryGradient,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Text(
          'Confirm Booking',
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
