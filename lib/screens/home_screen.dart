import 'package:flutter/material.dart';
import 'ride_details_screen.dart';
import 'upcoming_rides_screen.dart';
import 'active_ride_details_screen.dart';
import 'ride_history_screen.dart';
import 'profile_screen.dart';
import 'support_screen.dart';
import '../utils/style_utils.dart';

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
    // const SupportScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: IndexedStack(index: _selectedIndex, children: _pages),
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
            // _buildNavItem(3, Icons.chat_bubble_outline_rounded, 'Support'),
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
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 30),
          _buildQuickActions(context),
          const SizedBox(height: 30),
          _buildSectionTitle(
            context,
            'Upcoming Scheduled Rides',
            const UpcomingRidesScreen(),
          ),
          const SizedBox(height: 16),
          _buildUpcomingRides(context),
          const SizedBox(height: 30),
          _buildSectionTitle(
            context,
            "Today's Assigned Rides",
            const UpcomingRidesScreen(),
          ),
          const SizedBox(height: 16),
          _buildAssignedRides(context),
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
          color: AppStyles.primaryButton,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppStyles.primaryButton.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
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
        'id': 'BK-102555',
        'date': '25 Oct',
        'time': '2:00 PM',
        'status': 'Upcoming',
        'from': '456 Elm St, San Francisco',
        'to': 'SFO Airport',
        'driver': 'Sarah Jenkins',
        'price': '\$150.00',
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

  Widget _buildAssignedRides(BuildContext context) {
    final rides = [
      {
        'id': 'BK-102356',
        'date': '24 Oct',
        'time': '10:00 AM',
        'status': 'Assigned',
        'from': 'Downtown Plaza',
        'to': 'Oakland Airport',
        'driver': 'John Doe',
        'price': '\$120.00',
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
    bool isUpcoming =
        ride['status'] == 'Scheduled' || ride['status'] == 'Upcoming';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppStyles.cardBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.white24),
                ),
                child: Text(
                  'Booking ID # ${ride['id']}',
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: isUpcoming ? AppStyles.upcomingBg : AppStyles.assignedBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  ride['status']!,
                  style: TextStyle(
                    color: isUpcoming
                        ? AppStyles.upcomingText
                        : AppStyles.assignedText,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: AppStyles.innerCardBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: (isUpcoming ? Colors.blue : Colors.orange)
                        .withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: (isUpcoming ? Colors.blue : Colors.orange)
                          .withValues(alpha: 0.3),
                    ),
                  ),
                  child: Text(
                    isUpcoming ? 'Scheduled Ride' : 'Assigned Ride',
                    style: TextStyle(
                      color: isUpcoming ? Colors.blue : Colors.orange,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  '${ride['date']} • ${ride['time']}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _buildLocationSection('Pickup', ride['from']!, Icons.gps_fixed),
          const SizedBox(height: 12),
          _buildLocationSection('Drop-Off', ride['to']!, Icons.location_on),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppStyles.innerCardBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage('https://i.pravatar.cc/150'),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    ride['driver'] ?? 'Sarah Jenkins',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                _buildCircularIcon(Icons.call, Colors.white12),
                const SizedBox(width: 8),
                _buildCircularIcon(Icons.chat_bubble, Colors.white12),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Rent To Collect',
                style: TextStyle(color: Colors.white54, fontSize: 13),
              ),
              Text(
                ride['price'] ?? '\$150.00',
                style: const TextStyle(
                  color: AppStyles.metallicYellow,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ActiveRideDetailsScreen(),
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppStyles.primaryButton,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: const Text(
                'View Details',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationSection(String label, String address, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white38, fontSize: 11),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Icon(icon, color: AppStyles.metallicYellow, size: 16),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                address,
                style: const TextStyle(color: Colors.white, fontSize: 14),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCircularIcon(IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      child: Icon(icon, color: Colors.white, size: 18),
    );
  }

}
