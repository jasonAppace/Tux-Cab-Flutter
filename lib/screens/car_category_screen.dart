import 'package:flutter/material.dart';
import 'price_breakdown_screen.dart';
import '../utils/style_utils.dart';


class CarCategoryScreen extends StatefulWidget {
  final bool rideShareEnabled;
  const CarCategoryScreen({super.key, required this.rideShareEnabled});

  @override
  State<CarCategoryScreen> createState() => _CarCategoryScreenState();
}

class _CarCategoryScreenState extends State<CarCategoryScreen> {
  late String _selectedCategory;

  final List<Map<String, dynamic>> _categories = [
    {
      'name': 'SUV',
      'year': '2025',
      'engine': 'Gasoline',
      'image': 'assets/images/suv.png',
      'baseFare': 80.0,
      'perMile': 4.50,
      'sublines': ['6 passengers', 'Luggage space'],
    },
    {
      'name': 'Standard Sedan',
      'year': '2025',
      'engine': 'Hybrid',
      'image': 'assets/images/standard.png',
      'baseFare': 30.0,
      'perMile': 2.75,
      'sublines': ['Base Fare', 'Per Mile Rate', 'Capacity: 3 passengers'],
    },
    {
      'name': 'Executive Sedan',
      'year': '2024',
      'engine': 'Diesel',
      'image': 'assets/images/sedan.png',
      'baseFare': 50.0,
      'perMile': 3.50,
      'sublines': ['Higher comfort', 'Base Fare', 'Per Mile Rate'],
    },
  ];

  @override
  void initState() {
    super.initState();
    _selectedCategory = _categories[0]['name'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                _buildCustomHeader(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        _buildStepIndicator(),
                        const SizedBox(height: 30),
                        ..._categories
                            .map((cat) => _buildCategoryCard(cat))
                            .toList(),
                        const SizedBox(height: 120),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _buildBottomAction(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppStyles.cardBg,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white10),
              ),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
          const Expanded(
            child: Text(
              'Select Ride',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _buildStepIndicator() {
    return Row(
      children: [
        Expanded(child: _buildStepSegment(active: true)),
        const SizedBox(width: 8),
        Expanded(child: _buildStepSegment(active: true)),
        const SizedBox(width: 8),
        Expanded(child: _buildStepSegment(active: false)),
      ],
    );
  }

  Widget _buildStepSegment({required bool active}) {
    return Container(
      height: 4,
      decoration: BoxDecoration(
        color: active ? AppStyles.metallicYellow : Colors.white10,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildCategoryCard(Map<String, dynamic> category) {
    bool isSelected = _selectedCategory == category['name'];
    double estimatedPrice = category['baseFare'] + (10 * category['perMile']);
    double discount = widget.rideShareEnabled ? (estimatedPrice * 0.15) : 0;
    double total = estimatedPrice - discount;

    return GestureDetector(
      onTap: () => setState(() => _selectedCategory = category['name']),
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: AppStyles.cardBg.withOpacity(0.5),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppStyles.metallicYellow : Colors.white10,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        _buildBadge(category['year']),
                        const SizedBox(width: 8),
                        _buildBadge(category['engine']),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      category['name'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: (category['sublines'] as List<String>)
                          .map(
                            (line) => Padding(
                              padding: const EdgeInsets.only(bottom: 2.0),
                              child: Text(
                                line,
                                style: const TextStyle(
                                  color: Colors.white54,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'USD ${total.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: -25,
                bottom: -15,
                child: IgnorePointer(
                  child: Image.asset(
                    category['image'],
                    width: 250,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) =>
                        const SizedBox(
                          width: 200,
                          height: 120,
                          child: Center(
                            child: Icon(
                              Icons.car_crash,
                              color: Colors.white10,
                              size: 50,
                            ),
                          ),
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF2A240A),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppStyles.metallicYellow.withOpacity(0.3)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: AppStyles.metallicYellow,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildBottomAction() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withOpacity(0),
            Colors.black.withOpacity(0.9),
            Colors.black,
          ],
        ),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PriceBreakdownScreen(
                category: _selectedCategory,
                rideShareEnabled: widget.rideShareEnabled,
              ),
            ),
          );
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            gradient: AppStyles.primaryGradient,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: AppStyles.metallicYellow.withOpacity(0.2),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Text(
            'Select $_selectedCategory',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
