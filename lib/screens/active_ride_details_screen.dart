import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'live_tracking_screen.dart';
import '../utils/style_utils.dart';
import '../utils/app_painters.dart';

class ActiveRideDetailsScreen extends StatelessWidget {
  const ActiveRideDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Ride Details',
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
          SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildMapSection(context),
                const SizedBox(height: 24),
                _buildDriverCard(),
                const SizedBox(height: 24),
                _buildStatusTimeline(),
                const SizedBox(height: 24),
                _buildRideInfo(),
                const SizedBox(height: 30),
                _buildContactRow(),
                const SizedBox(height: 20),
                _buildEmergencyButton(),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapSection(BuildContext context) {
    return Container(
      height: 220,
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: LatLng(38.5816, -121.4944),
                zoom: 14,
              ),
              zoomControlsEnabled: false,
              myLocationButtonEnabled: false,
              mapToolbarEnabled: false,
              onMapCreated: (controller) {
                // controller.setMapStyle(_darkMapStyle);
              },
            ),
            Positioned(
              top: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: const [
                    Icon(
                      Icons.access_time_filled,
                      color: AppStyles.metallicYellow,
                      size: 16,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'ETA: 12 Mins',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 12,
              left: 12,
              right: 12,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LiveTrackingScreen(),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    gradient: AppStyles.primaryGradient,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.gps_fixed, color: Colors.black, size: 18),
                      SizedBox(width: 8),
                      Text(
                        'TRACK LIVE TRIP',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmergencyButton() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.warning_amber_rounded, color: Colors.red, size: 20),
          SizedBox(width: 12),
          Text(
            'EMERGENCY SOS',
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDriverCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 35,
                backgroundImage: NetworkImage(
                  'https://i.pravatar.cc/150?u=driver',
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Michael Thompson',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Executive Sedan • Silver BMW 7 Series',
                      style: TextStyle(color: Colors.white54, fontSize: 13),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Plate: TX-S7792',
                      style: TextStyle(
                        color: AppStyles.metallicYellow,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const Column(
                children: [
                  Icon(Icons.star, color: AppStyles.metallicYellow, size: 20),
                  Text(
                    '4.9',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusTimeline() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Ride Status',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          _buildTimelineStep('Scheduled', 'Oct 24, 2024 • 08:00 AM', true),
          _buildTimelineStep('Assigned', 'Oct 24, 2024 • 09:15 AM', true),
          _buildTimelineStep(
            'Driver En Route',
            'Arriving in 12 mins',
            false,
            isCurrent: true,
          ),
          _buildTimelineStep('Arrived', '', false),
          _buildTimelineStep('Ride Started', '', false),
          _buildTimelineStep('Completed', '', false),
        ],
      ),
    );
  }

  Widget _buildTimelineStep(
    String title,
    String subtitle,
    bool isDone, {
    bool isCurrent = false,
  }) {
    return Row(
      children: [
        Column(
          children: [
            Icon(
              isDone
                  ? Icons.check_circle
                  : (isCurrent
                        ? Icons.radio_button_checked
                        : Icons.radio_button_off),
              color: isDone
                  ? AppStyles.metallicYellow
                  : (isCurrent ? AppStyles.metallicYellow : Colors.white24),
              size: 20,
            ),
            Container(width: 2, height: 20, color: Colors.white10),
          ],
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: isDone || isCurrent ? Colors.white : Colors.white38,
                fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            if (subtitle.isNotEmpty)
              Text(
                subtitle,
                style: const TextStyle(color: Colors.white54, fontSize: 11),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildRideInfo() {
    return Column(
      children: [
        _buildInfoRow(
          Icons.location_on,
          'Pickup',
          'Sacramento International Airport (SMF)',
        ),
        const SizedBox(height: 16),
        _buildInfoRow(
          Icons.flag_rounded,
          'Drop-off',
          'The Ritz-Carlton, Sacramento',
        ),
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: AppStyles.metallicYellow, size: 20),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(color: Colors.white54, fontSize: 12),
              ),
              Text(
                value,
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContactRow() {
    return Row(
      children: [
        Expanded(
          child: _buildContactButton(Icons.call, 'Call Driver', Colors.green),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildContactButton(Icons.message, 'Message', Colors.blue),
        ),
      ],
    );
  }

  Widget _buildContactButton(IconData icon, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
