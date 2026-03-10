import 'package:flutter/material.dart';
import 'home_screen.dart';
import '../utils/style_utils.dart';


class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  final _formKey = GlobalKey<FormState>();
  final _cardNumberController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();
  final _cardHolderController = TextEditingController();
  final _billingAddressController = TextEditingController();

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    _cardHolderController.dispose();
    _billingAddressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),
                const Text(
                  'Add Payment Method',
                  style: AppStyles.headingStyle,
                ),
                const SizedBox(height: 12),
                const Text(
                  'Powered by Stripe (US Compliance)',
                  style: TextStyle(
                    color: AppStyles.metallicYellow,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 40),

                // Card Preview Mock
                _buildCardPreview(),

                const SizedBox(height: 40),

                // Cardholder Name
                const Text('Cardholder Name', style: AppStyles.labelStyle),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _cardHolderController,
                  style: const TextStyle(color: Colors.white),
                  decoration: AppStyles.inputDecoration(
                    hintText: 'FULL NAME',
                    prefixIcon: const Icon(
                      Icons.person_outline,
                      color: Colors.white70,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Card Number
                const Text('Card Number', style: AppStyles.labelStyle),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _cardNumberController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.white),
                  decoration: AppStyles.inputDecoration(
                    hintText: 'XXXX XXXX XXXX XXXX',
                    prefixIcon: const Icon(
                      Icons.credit_card,
                      color: Colors.white70,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Expiry and CVV
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Expiry Date',
                            style: AppStyles.labelStyle,
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _expiryController,
                            keyboardType: TextInputType.datetime,
                            style: const TextStyle(color: Colors.white),
                            decoration: AppStyles.inputDecoration(
                              hintText: 'MM/YY',
                              prefixIcon: const Icon(
                                Icons.calendar_today_outlined,
                                color: Colors.white70,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('CVV', style: AppStyles.labelStyle),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _cvvController,
                            keyboardType: TextInputType.number,
                            obscureText: true,
                            style: const TextStyle(color: Colors.white),
                            decoration: AppStyles.inputDecoration(
                              hintText: '***',
                              prefixIcon: const Icon(
                                Icons.lock_outline,
                                color: Colors.white70,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Billing Address
                const Text(
                  'Billing Address (US format)',
                  style: AppStyles.labelStyle,
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _billingAddressController,
                  style: const TextStyle(color: Colors.white),
                  maxLines: 2,
                  decoration: AppStyles.inputDecoration(
                    hintText: 'Street, City, Zip Code',
                    prefixIcon: const Icon(
                      Icons.location_on_outlined,
                      color: Colors.white70,
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                // Save Card Button
                GestureDetector(
                  onTap: _saveCard,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      gradient: AppStyles.primaryGradient,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'Save Card',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCardPreview() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1E1E1E), Color(0xFF111111)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppStyles.metallicYellow.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppStyles.metallicYellow.withOpacity(0.1),
            blurRadius: 15,
            spreadRadius: 2,
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.contactless, color: Colors.white54, size: 30),
              Image.asset(
                'assets/images/google_icon.png',
                width: 30,
              ), // Placeholder for card type
            ],
          ),
          const Spacer(),
          const Text(
            'XXXX XXXX XXXX XXXX',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'CARD HOLDER',
                    style: TextStyle(color: Colors.white54, fontSize: 10),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'FULL NAME',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'EXPIRES',
                    style: TextStyle(color: Colors.white54, fontSize: 10),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'MM/YY',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _saveCard() {
    if (_formKey.currentState!.validate()) {
      // Logic for saving card
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Payment Method Saved!')));

      // Navigate to Home Dashboard
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (route) => false,
      );
    }
  }
}
