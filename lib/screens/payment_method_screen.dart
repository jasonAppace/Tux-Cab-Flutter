import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'home_screen.dart';
import '../utils/style_utils.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  final _formKey = GlobalKey<FormState>();
  final _cardHolderController = TextEditingController();
  final _billingAddressController = TextEditingController();
  final CardFormEditController _cardEditController = CardFormEditController();

  @override
  void dispose() {
    _cardHolderController.dispose();
    _billingAddressController.dispose();
    _cardEditController.dispose();
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

                // Card Details (Stripe)
                const Text('Card Information', style: AppStyles.labelStyle),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1A1A).withOpacity(0.5),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white.withOpacity(0.1)),
                  ),
                  child: CardFormField(
                    controller: _cardEditController,
                    style: CardFormStyle(
                      textColor: Colors.white,
                      placeholderColor: Colors.white24,
                      backgroundColor: Colors.transparent,
                      cursorColor: AppStyles.metallicYellow,
                      textErrorColor: Colors.redAccent,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

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
                    width: double.infinity,
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

  void _saveCard() async {
    if (_formKey.currentState!.validate()) {
      if (!_cardEditController.details.complete) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please complete your card details.')),
        );
        return;
      }

      try {
        // Show loading
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const Center(child: CircularProgressIndicator()),
        );

        // Create PaymentMethod using Stripe
        final billingDetails = BillingDetails(
          name: _cardHolderController.text.isNotEmpty ? _cardHolderController.text : null,
          address: Address(
            line1: _billingAddressController.text,
            city: '',
            country: 'US',
            line2: '',
            postalCode: '',
            state: '',
          ),
        );

        final paymentMethod = await Stripe.instance.createPaymentMethod(
          params: PaymentMethodParams.card(
            paymentMethodData: PaymentMethodData(
              billingDetails: billingDetails,
            ),
          ),
        );

        // Hide loading
        if (mounted) Navigator.pop(context);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(content: Text('Success! Payment Method ID: ${paymentMethod.id}')),
          );
          
          // Return the payment method to the previous screen or navigate to home
          Navigator.pop(context, paymentMethod);
        }
      } catch (e) {
        // Hide loading
        if (mounted) Navigator.pop(context);
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error creating payment method: $e')),
          );
        }
      }
    }
  }
}
