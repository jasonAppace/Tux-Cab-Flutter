import 'package:flutter/material.dart';
import '../utils/style_utils.dart';
import '../utils/app_painters.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Profile', style: TextStyle(color: Colors.white)),
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          CustomPaint(painter: GridPatternPainter(), size: Size.infinite),
          SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                _buildProfileHeader(),
                const SizedBox(height: 40),
                _buildProfileSection('Account Details', [
                  _buildProfileItem(Icons.person_outline, 'Name', 'John Doe'),
                  _buildProfileItem(
                    Icons.email_outlined,
                    'Email',
                    'john.doe@example.com',
                  ),
                  _buildProfileItem(
                    Icons.phone_outlined,
                    'Phone',
                    '+1 (555) 000-1234',
                  ),
                ]),
                const SizedBox(height: 30),
                _buildProfileSection('Saved Information', [
                  _buildProfileItem(
                    Icons.home_outlined,
                    'Home',
                    '123 Sacramento St',
                  ),
                  _buildProfileItem(
                    Icons.work_outline,
                    'Work',
                    '456 Business Park',
                  ),
                  _buildProfileItem(
                    Icons.credit_card,
                    'Saved Cards',
                    'Visa ending in 4242',
                  ),
                ]),
                const SizedBox(height: 30),
                _buildProfileSection('Preferences', [
                  _buildProfileItem(
                    Icons.notifications_none,
                    'Notifications',
                    'Enabled',
                  ),
                  _buildProfileItem(Icons.language, 'Language', 'English'),
                ]),
                const SizedBox(height: 40),
                _buildLogoutButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: AppStyles.metallicYellow,
                shape: BoxShape.circle,
              ),
              child: const CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage('https://i.pravatar.cc/300'),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.camera_alt,
                  size: 16,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text(
          'John Doe',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildProfileSection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: AppStyles.metallicYellow,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1A),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white10),
          ),
          child: Column(children: items),
        ),
      ],
    );
  }

  Widget _buildProfileItem(IconData icon, String label, String value) {
    return ListTile(
      leading: Icon(icon, color: Colors.white70, size: 20),
      title: Text(
        label,
        style: const TextStyle(color: Colors.white54, fontSize: 12),
      ),
      subtitle: Text(
        value,
        style: const TextStyle(color: Colors.white, fontSize: 15),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: Colors.white24,
        size: 20,
      ),
    );
  }

  Widget _buildLogoutButton() {
    return TextButton(
      onPressed: () {},
      child: const Text(
        'Log Out',
        style: TextStyle(
          color: Colors.redAccent,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
