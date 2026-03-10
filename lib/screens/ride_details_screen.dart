import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'car_category_screen.dart';
import 'map_picker_screen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import '../utils/style_utils.dart';
import '../utils/app_painters.dart';

const String GOOGLE_API_KEY = "AIzaSyAWFKJ1njXCiIyV2cjG5kcO87xJyIK6GGM";

class RideDetailsScreen extends StatefulWidget {
  const RideDetailsScreen({super.key});

  @override
  State<RideDetailsScreen> createState() => _RideDetailsScreenState();
}

class _RideDetailsScreenState extends State<RideDetailsScreen> {
  final _pickupController = TextEditingController();
  final _dropoffController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String _bookingType = 'One Way';
  bool _shareRide = false;
  int _extraWaitingHours = 0;
  LatLng? _currentPosition;

  @override
  void initState() {
    super.initState();
    DateTime defaultDateTime = DateTime.now().add(const Duration(hours: 7));
    _selectedDate = defaultDateTime;
    _selectedTime = TimeOfDay.fromDateTime(defaultDateTime);
    _fetchCurrentLocation();
  }

  Future<void> _fetchCurrentLocation() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) return;

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) return;
      }

      if (permission == LocationPermission.deniedForever) return;

      Position position = await Geolocator.getCurrentPosition();
      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
        _pickupController.text = "Fetching current address...";
      });

      String? address = await _getAddressFromLatLng(_currentPosition!);
      if (mounted) {
        setState(() {
          _pickupController.text = address ?? "";
        });
      }
    } catch (e) {
      debugPrint("Error fetching location: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          CustomPaint(painter: GridPatternPainter(), size: Size.infinite),
          SafeArea(
            child: Column(
              children: [
                _buildCustomHeader(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        _buildStepIndicator(),
                        const SizedBox(height: 30),
                        const Text(
                          'Start Your Journey',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Experience the ultimate luxury with our pre-scheduled premium rides in the Greater Sacramento Area.',
                          style: TextStyle(
                            color: Colors.white54,
                            fontSize: 13,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 30),
                        _buildLabeledInput(
                          label: 'Pickup Address',
                          child: _buildLocationField(
                            controller: _pickupController,
                            hintText: 'Enter pickup address',
                            icon: Icons.search,
                            suffix: IconButton(
                              icon: const Icon(
                                Icons.map_outlined,
                                color: AppStyles.metallicYellow,
                                size: 20,
                              ),
                              onPressed: () => _handleMapPick(isPickup: true),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildLabeledInput(
                          label: 'Drop-off Address',
                          child: _buildLocationField(
                            controller: _dropoffController,
                            hintText: 'Enter drop-off address',
                            icon: Icons.search,
                            suffix: IconButton(
                              icon: const Icon(
                                Icons.map_outlined,
                                color: AppStyles.metallicYellow,
                                size: 20,
                              ),
                              onPressed: () => _handleMapPick(isPickup: false),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildLabeledInput(
                          label: 'Pickup Date',
                          child: _buildSelectableField(
                            label: _selectedDate == null
                                ? 'Select Date'
                                : DateFormat(
                                    'EEEE, MMM dd',
                                  ).format(_selectedDate!),
                            icon: Icons.calendar_today_outlined,
                            onTap: _pickDate,
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildLabeledInput(
                          label: 'Pickup Time',
                          child: _buildSelectableField(
                            label: _selectedTime == null
                                ? 'Select Time'
                                : _selectedTime!.format(context),
                            icon: Icons.access_time,
                            onTap: _pickTime,
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildLabeledInput(
                          label: 'Extra Waiting Hours',
                          child: _buildWaitingHoursDropdown(),
                        ),
                        const SizedBox(height: 24),
                        _buildBookingType(),
                        const SizedBox(height: 24),
                        _buildRideShareToggle(),
                        const SizedBox(height: 40),
                        _buildContinueButton(),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
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
              'Ride Booking',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 48), // Equal space for alignment
        ],
      ),
    );
  }

  Widget _buildStepIndicator() {
    return Row(
      children: [
        Expanded(child: _buildStepSegment(active: true)),
        const SizedBox(width: 8),
        Expanded(child: _buildStepSegment(active: false)),
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

  Widget _buildLabeledInput({required String label, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 14),
        ),
        const SizedBox(height: 10),
        child,
      ],
    );
  }

  Widget _buildLocationField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    Widget? suffix,
  }) {
    return GooglePlaceAutoCompleteTextField(
      textEditingController: controller,
      googleAPIKey: GOOGLE_API_KEY,
      inputDecoration:
          AppStyles.inputDecoration(
            hintText: hintText,
            prefixIcon: Icon(icon, color: Colors.white54, size: 20),
            suffixIcon: suffix,
          ).copyWith(
            filled: true,
            fillColor: const Color(0xFF1A1A1A),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.white10),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.white10),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppStyles.metallicYellow,
                width: 1,
              ),
            ),
          ),
      isCrossBtnShown: false,
      textStyle: const TextStyle(color: Colors.white, fontSize: 14),
      debounceTime: 800,
      countries: const ["us"],
      itemClick: (Prediction prediction) {
        controller.text = prediction.description ?? "";
        controller.selection = TextSelection.fromPosition(
          TextPosition(offset: prediction.description?.length ?? 0),
        );
      },
      itemBuilder: (context, index, Prediction prediction) {
        return Container(
          padding: const EdgeInsets.all(12),
          color: AppStyles.cardBg,
          child: Row(
            children: [
              const Icon(
                Icons.location_on,
                color: AppStyles.metallicYellow,
                size: 16,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  prediction.description ?? "",
                  style: const TextStyle(color: Colors.white, fontSize: 13),
                ),
              ),
            ],
          ),
        );
      },
      seperatedBuilder: const Divider(height: 1, color: Colors.white10),
    );
  }

  Widget _buildSelectableField({
    required String label,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white10),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white54, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
            const Icon(
              Icons.keyboard_arrow_down,
              color: Colors.white54,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWaitingHoursDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          value: _extraWaitingHours,
          dropdownColor: AppStyles.cardBg,
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: Colors.white54,
            size: 20,
          ),
          isExpanded: true,
          style: const TextStyle(color: Colors.white, fontSize: 14),
          onChanged: (int? newValue) {
            if (newValue != null) {
              setState(() => _extraWaitingHours = newValue);
            }
          },
          items: List.generate(13, (index) => index).map<DropdownMenuItem<int>>(
            (int value) {
              return DropdownMenuItem<int>(
                value: value,
                child: Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      color: Colors.white54,
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Text('$value Hours'),
                  ],
                ),
              );
            },
          ).toList(),
        ),
      ),
    );
  }

  Widget _buildContinueButton() {
    return SizedBox(
      width: double.infinity,
      child: GestureDetector(
        onTap: _validateAndContinue,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            gradient: AppStyles.primaryGradient,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: AppStyles.metallicYellow.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Text(
            'Continue',
            style: TextStyle(
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

  Future<void> _handleMapPick({required bool isPickup}) async {
    LatLng? picked = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MapPickerScreen(
          title: isPickup
              ? 'Select Pickup Location'
              : 'Select Drop-Off Location',
          initialLocation: _currentPosition ?? const LatLng(38.5816, -121.4944),
        ),
      ),
    );
    if (picked != null) {
      // Show loading state in text field
      setState(() {
        if (isPickup) {
          _pickupController.text = "Fetching address...";
        } else {
          _dropoffController.text = "Fetching address...";
        }
      });

      String? address = await _getAddressFromLatLng(picked);

      setState(() {
        if (isPickup) {
          _pickupController.text =
              address ??
              '${picked.latitude.toStringAsFixed(4)}, ${picked.longitude.toStringAsFixed(4)}';
        } else {
          _dropoffController.text =
              address ??
              '${picked.latitude.toStringAsFixed(4)}, ${picked.longitude.toStringAsFixed(4)}';
        }
      });
    }
  }

  Future<String?> _getAddressFromLatLng(LatLng position) async {
    try {
      final url =
          'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$GOOGLE_API_KEY';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'OK' && data['results'].isNotEmpty) {
          return data['results'][0]['formatted_address'];
        }
      }
    } catch (e) {
      debugPrint("Geocoding Error: $e");
    }
    return null;
  }

  void _pickDate() async {
    DateTime now = DateTime.now();
    DateTime firstDay = DateTime(now.year, now.month, now.day);

    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? firstDay,
      firstDate: firstDay,
      lastDate: now.add(const Duration(days: 30)),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppStyles.metallicYellow,
              onPrimary: Colors.black,
              surface: AppStyles.darkBg,
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  void _pickTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppStyles.metallicYellow,
              onPrimary: Colors.black,
              surface: AppStyles.darkBg,
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => _selectedTime = picked);
    }
  }

  Widget _buildBookingType() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Booking Type',
          style: TextStyle(color: Colors.white70, fontSize: 14),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            _buildTypeChip('One Way'),
            const SizedBox(width: 12),
            _buildTypeChip('Round Trip'),
          ],
        ),
      ],
    );
  }

  Widget _buildTypeChip(String type) {
    bool isSelected = _bookingType == type;
    return GestureDetector(
      onTap: () => setState(() => _bookingType = type),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? AppStyles.metallicYellow
              : const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppStyles.metallicYellow : Colors.white10,
          ),
        ),
        child: Text(
          type,
          style: TextStyle(
            color: isSelected ? Colors.black : Colors.white,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildRideShareToggle() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppStyles.metallicYellow.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppStyles.metallicYellow.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.people_alt_rounded,
                color: AppStyles.metallicYellow,
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Share this ride & Save',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Switch(
                value: _shareRide,
                onChanged: (val) => setState(() => _shareRide = val),
                activeColor: AppStyles.metallicYellow,
              ),
            ],
          ),
          if (_shareRide)
            const Padding(
              padding: EdgeInsets.only(top: 8.0, left: 36),
              child: Text(
                '“If another passenger joins, you receive a discount.”',
                style: TextStyle(
                  color: AppStyles.metallicYellow,
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _validateAndContinue() {
    if (_pickupController.text.isEmpty || _dropoffController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter pickup and drop-off locations'),
        ),
      );
      return;
    }
    if (_selectedDate == null || _selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select date and time')),
      );
      return;
    }

    DateTime selectedDateTime = DateTime(
      _selectedDate!.year,
      _selectedDate!.month,
      _selectedDate!.day,
      _selectedTime!.hour,
      _selectedTime!.minute,
    );

    if (selectedDateTime.isBefore(
      DateTime.now().add(const Duration(hours: 6)),
    )) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Booking must be at least 6-8 hours in advance'),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CarCategoryScreen(rideShareEnabled: _shareRide),
      ),
    );
  }
}
