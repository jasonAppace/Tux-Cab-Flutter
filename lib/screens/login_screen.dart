import 'package:flutter/material.dart';
import 'signup_screen.dart';
import 'home_screen.dart';
import '../utils/style_utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Form controllers
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Password visibility
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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

              // Login Card
              _buildLoginCard(context),

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
    );
  }

  Widget _buildLoginCard(BuildContext context) {
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
              'Login Your Account',
              style: AppStyles.headingStyle,
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 12),
            const Text(
              'Enter your information and Login to your account',
              style: AppStyles.bodyStyle,
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 32),

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

            // Password Field
            const Text('Password', style: AppStyles.labelStyle),
            const SizedBox(height: 8),
            TextFormField(
              controller: _passwordController,
              obscureText: !_isPasswordVisible,
              style: const TextStyle(color: Colors.white),
              decoration: AppStyles.inputDecoration(
                hintText: 'Enter Password',
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

            // Forgot Password Link
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  'Forgot password?',
                  style: TextStyle(color: Colors.redAccent, fontSize: 13),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Sign In Button
            GestureDetector(
              onTap: _handleSignIn,
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
                  'Sign In',
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
          'New here? ',
          style: TextStyle(color: Colors.white70, fontSize: 15),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const SignupScreen()),
            );
          },
          child: const Text(
            'Create an account',
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

  void _handleSignIn() {
    if (_formKey.currentState!.validate()) {
      // Logic for signing in
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (route) => false,
      );
    }
  }
}
