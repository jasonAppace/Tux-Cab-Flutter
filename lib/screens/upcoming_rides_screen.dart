import 'package:flutter/material.dart';
import '../utils/style_utils.dart';


import 'active_ride_details_screen.dart';

class UpcomingRidesScreen extends StatelessWidget {
  const UpcomingRidesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Upcoming Rides',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _buildRidesList(context),
    );
  }

  Widget _buildRidesList(BuildContext context) {
    // Mock data
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

    if (rides.isEmpty) {
      return const Center(
        child: Text(
          'No upcoming rides scheduled.',
          style: TextStyle(color: Colors.white54),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: rides.length,
      itemBuilder: (context, index) {
        final ride = rides[index];
        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ActiveRideDetailsScreen(),
            ),
          ),
          child: Container(
            margin: const EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A1A),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white10),
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
                    _buildStatusBadge(ride['status']!),
                  ],
                ),
                const Divider(color: Colors.white10, height: 30),
                _buildLocationRow(
                  Icons.radio_button_checked,
                  ride['from']!,
                  Colors.greenAccent,
                ),
                const SizedBox(height: 12),
                _buildLocationRow(
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
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(child: _buildOutlineButton('Cancel', () {})),
                    const SizedBox(width: 12),
                    Expanded(child: _buildGradientButton('Modify', () {})),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatusBadge(String status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: status == 'Scheduled'
            ? Colors.blueAccent.withOpacity(0.2)
            : Colors.orangeAccent.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: status == 'Scheduled'
              ? Colors.blueAccent
              : Colors.orangeAccent,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildLocationRow(IconData icon, String label, Color color) {
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

  Widget _buildOutlineButton(String label, VoidCallback onTap) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Colors.redAccent),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(label, style: const TextStyle(color: Colors.redAccent)),
    );
  }

  Widget _buildGradientButton(String label, VoidCallback onTap) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppStyles.primaryGradient,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
