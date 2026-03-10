import 'package:flutter/material.dart';
import 'package:tux_cab/screens/ride_completion_screen.dart';
import 'ride_details_screen.dart';
import 'upcoming_rides_screen.dart';
import 'active_ride_details_screen.dart';
import 'ride_history_screen.dart';
import 'profile_screen.dart';
import 'support_screen.dart';
import '../utils/style_utils.dart';
import '../utils/app_painters.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const _HomeMainBody(),
    const RideHistoryScreen(),
    const ProfileScreen(),
    const SupportScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          CustomPaint(painter: GridPatternPainter(), size: Size.infinite),
          SafeArea(
            child: IndexedStack(index: _selectedIndex, children: _pages),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      height: 90,
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(0, Icons.search_rounded, 'Explore'),
            _buildNavItem(1, Icons.route_rounded, 'History'),
            _buildNavItem(3, Icons.chat_bubble_outline_rounded, 'Support'),
            _buildNavItem(2, Icons.more_horiz_rounded, 'Profile'),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF333333) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.white54,
              size: 24,
            ),
            if (isSelected) ...[
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _HomeMainBody extends StatelessWidget {
  const _HomeMainBody();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 30),
          _buildQuickActions(context),
          const SizedBox(height: 30),
          _buildSectionTitle(
            context,
            'Upcoming Rides',
            const UpcomingRidesScreen(),
          ),
          const SizedBox(height: 16),
          _buildUpcomingRides(context),
          const SizedBox(height: 30),
          _buildSectionTitle(context, 'Past Rides', const RideHistoryScreen()),
          const SizedBox(height: 16),
          _buildPastRides(context),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Hello, Guest!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Where would you like to go today?',
              style: TextStyle(color: Colors.white54, fontSize: 14),
            ),
          ],
        ),
        const CircleAvatar(
          radius: 25,
          backgroundColor: AppStyles.cardBg,
          child: Icon(
            Icons.person_pin,
            color: AppStyles.metallicYellow,
            size: 30,
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RideDetailsScreen()),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: AppStyles.primaryGradient,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppStyles.metallicYellow.withOpacity(0.2),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            const Icon(Icons.car_rental_rounded, size: 40, color: Colors.black),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Book a Ride',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Luxury pre-scheduled rides in Sacramento',
                    style: TextStyle(color: Colors.black87, fontSize: 13),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.black,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title, Widget screen) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          height: 32,
          padding: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1A),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white10),
          ),
          child: TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => screen),
              );
            },
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text(
              'View All',
              style: TextStyle(
                color: AppStyles.metallicYellow,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUpcomingRides(BuildContext context) {
    final rides = [
      {
        'id': '#TX-99821',
        'date': 'Oct 24, 2024',
        'time': '10:30 AM',
        'status': 'Pending Assignment',
        'from': 'Sacramento Intl Airport',
        'to': 'Downtown Sacramento',
      },
      {
        'id': '#TX-99750',
        'date': 'Oct 28, 2024',
        'time': '02:00 PM',
        'status': 'Scheduled',
        'from': 'Roseville, CA',
        'to': 'Sacramento Airport',
      },
    ];

    return Column(
      children: rides
          .map(
            (ride) => Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: _buildRideCard(context, ride),
            ),
          )
          .toList(),
    );
  }

  Widget _buildRideCard(BuildContext context, Map<String, String> ride) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ActiveRideDetailsScreen(),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppStyles.cardBg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  ride['id']!,
                  style: const TextStyle(
                    color: AppStyles.metallicYellow,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color:
                        (ride['status'] == 'Scheduled'
                                ? Colors.blueAccent
                                : Colors.orangeAccent)
                            .withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    ride['status']!,
                    style: TextStyle(
                      color: ride['status'] == 'Scheduled'
                          ? Colors.blueAccent
                          : Colors.orangeAccent,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(color: Colors.white10, height: 30),
            _buildRideLocationRow(
              Icons.radio_button_checked,
              ride['from']!,
              Colors.greenAccent,
            ),
            const SizedBox(height: 12),
            _buildRideLocationRow(
              Icons.location_on,
              ride['to']!,
              Colors.redAccent,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Icon(
                  Icons.calendar_today,
                  color: Colors.white54,
                  size: 14,
                ),
                const SizedBox(width: 8),
                Text(
                  '${ride['date']} • ${ride['time']}',
                  style: const TextStyle(color: Colors.white70, fontSize: 13),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRideLocationRow(IconData icon, String label, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 16),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 14),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildPastRides(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const RideCompletionScreen()),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppStyles.cardBg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white12),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.history, color: AppStyles.metallicYellow),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Sacramento Int Airport',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Oct 24, 2024 • 10:30 AM',
                    style: TextStyle(color: Colors.white54, fontSize: 12),
                  ),
                ],
              ),
            ),
            const Text(
              '\$45.00',
              style: TextStyle(
                color: AppStyles.metallicYellow,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
