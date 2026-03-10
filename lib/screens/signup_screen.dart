import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'otp_verification_screen.dart';
import '../utils/style_utils.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // Form controllers
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // Password visibility
  bool _isPasswordVisible = false;
  bool _agreeToTerms = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background image with texture/pattern
          Positioned.fill(
            child: Opacity(
              opacity: 0.15,
              child: Image.asset(
                'assets/images/login_background.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Main content
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  // Header Image
                  Image.asset(
                    'assets/images/header_image.png',
                    height: 100,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 30),

                  // Signup Card
                  _buildSignupCard(context),

                  const SizedBox(height: 40),

                  // Social Login Section
                  _buildSocialLoginSection(),

                  const SizedBox(height: 40),

                  // Footer link
                  _buildFooterLink(context),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignupCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF161B22).withOpacity(0.4),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Create an Account',
              style: AppStyles.headingStyle,
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 12),
            const Text(
              'Enter your information and Create your new account',
              style: AppStyles.bodyStyle,
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 32),

            // Name Row
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('First Name', style: AppStyles.labelStyle),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _firstNameController,
                        style: const TextStyle(color: Colors.white),
                        decoration: AppStyles.inputDecoration(
                          hintText: 'First',
                          prefixIcon: const Icon(
                            Icons.person_outline,
                            color: Colors.white70,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Last Name', style: AppStyles.labelStyle),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _lastNameController,
                        style: const TextStyle(color: Colors.white),
                        decoration: AppStyles.inputDecoration(
                          hintText: 'Last',
                          prefixIcon: const Icon(
                            Icons.person_outline,
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

            // Email Field
            const Text('Email', style: AppStyles.labelStyle),
            const SizedBox(height: 8),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(color: Colors.white),
              decoration: AppStyles.inputDecoration(
                hintText: 'Enter email',
                prefixIcon: const Icon(
                  Icons.mail_outline_rounded,
                  color: Colors.white70,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Mobile Number Field
            const Text('Mobile Number', style: AppStyles.labelStyle),
            const SizedBox(height: 8),
            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              style: const TextStyle(color: Colors.white),
              decoration: AppStyles.inputDecoration(
                hintText: 'USA Format (+1)',
                prefixIcon: const Icon(
                  Icons.phone_iphone_rounded,
                  color: Colors.white70,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Password Field
            const Text('Password', style: AppStyles.labelStyle),
            const SizedBox(height: 8),
            TextFormField(
              controller: _passwordController,
              obscureText: !_isPasswordVisible,
              style: const TextStyle(color: Colors.white),
              decoration: AppStyles.inputDecoration(
                hintText: 'Create Password',
                prefixIcon: const Icon(
                  Icons.lock_outline_rounded,
                  color: Colors.white70,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility_rounded
                        : Icons.visibility_off_rounded,
                    color: Colors.white24,
                  ),
                  onPressed: () =>
                      setState(() => _isPasswordVisible = !_isPasswordVisible),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Confirm Password Field
            const Text('Confirm Password', style: AppStyles.labelStyle),
            const SizedBox(height: 8),
            TextFormField(
              controller: _confirmPasswordController,
              obscureText: !_isPasswordVisible,
              style: const TextStyle(color: Colors.white),
              decoration: AppStyles.inputDecoration(
                hintText: 'Re-enter Password',
                prefixIcon: const Icon(
                  Icons.lock_clock_outlined,
                  color: Colors.white70,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Terms & Conditions
            Row(
              children: [
                SizedBox(
                  height: 24,
                  width: 24,
                  child: Checkbox(
                    value: _agreeToTerms,
                    onChanged: (val) =>
                        setState(() => _agreeToTerms = val ?? false),
                    activeColor: AppStyles.metallicYellow,
                    checkColor: Colors.black,
                    side: const BorderSide(color: Colors.white24),
                  ),
                ),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'I agree to the Terms & Privacy Policy',
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Sign Up Button
            GestureDetector(
              onTap: _handleSignUp,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  gradient: AppStyles.primaryGradient,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: AppStyles.metallicYellow.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialLoginSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSocialBtn('assets/images/facebook_icon.png'),
        const SizedBox(width: 20),
        _buildSocialBtn('assets/images/google_icon.png'),
        const SizedBox(width: 20),
        _buildSocialBtn('assets/images/apple_icon.png'),
      ],
    );
  }

  Widget _buildSocialBtn(String assetPath) {
    return Container(
      width: 80,
      height: 50,
      decoration: BoxDecoration(
        color: const Color(0xFF161B22).withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
      ),
      child: Center(child: Image.asset(assetPath, width: 24, height: 24)),
    );
  }

  Widget _buildFooterLink(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Already a member? ',
          style: TextStyle(color: Colors.white70, fontSize: 15),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          },
          child: const Text(
            'Login Now',
            style: TextStyle(
              color: AppStyles.metallicYellow,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  void _handleSignUp() {
    if (_formKey.currentState!.validate()) {
      if (!_agreeToTerms) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please agree to the Terms & Privacy Policy'),
          ),
        );
        return;
      }

      // Navigate to OTP Verification
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              OtpVerificationScreen(emailOrPhone: _emailController.text),
        ),
      );
    }
  }
}
