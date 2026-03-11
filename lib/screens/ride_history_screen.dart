import 'package:flutter/material.dart';
import '../utils/style_utils.dart';


class RideHistoryScreen extends StatelessWidget {
  const RideHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Ride History',
          style: TextStyle(color: Colors.white),
        ),
        automaticallyImplyLeading: true,
        leading: Navigator.canPop(context)
            ? IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              )
            : null,
      ),
      body: _buildHistoryList(),
    );
  }

  Widget _buildHistoryList() {
    // Mock data
    final history = [
      {
        'id': '#TX-98102',
        'date': 'Sep 12, 2024',
        'amount': '\$125.00',
        'status': 'Completed',
        'from': 'San Francisco',
        'to': 'Sacramento Intl Airport',
      },
      {
        'id': '#TX-97554',
        'date': 'Aug 30, 2024',
        'amount': '\$85.50',
        'status': 'Completed',
        'from': 'Sacramento',
        'to': 'Roseville',
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: history.length,
      itemBuilder: (context, index) {
        final ride = history[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1A),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white10),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    ride['id']!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    ride['amount']!,
                    style: const TextStyle(
                      color: AppStyles.metallicYellow,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _buildSimpleLocation(ride['from']!, ride['to']!),
              const Divider(color: Colors.white10, height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    ride['date']!,
                    style: const TextStyle(color: Colors.white54, fontSize: 12),
                  ),
                  Row(
                    children: [
                      TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.download,
                          size: 16,
                          color: AppStyles.metallicYellow,
                        ),
                        label: const Text(
                          'Invoice',
                          style: TextStyle(
                            color: AppStyles.metallicYellow,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppStyles.metallicYellow,
                          minimumSize: const Size(80, 30),
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Rebook',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSimpleLocation(String from, String to) {
    return Column(
      children: [
        Row(
          children: [
            const Icon(
              Icons.radio_button_checked,
              color: Colors.green,
              size: 12,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                from,
                style: const TextStyle(color: Colors.white70, fontSize: 13),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            const Icon(Icons.location_on, color: Colors.red, size: 12),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                to,
                style: const TextStyle(color: Colors.white70, fontSize: 13),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
