import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:lodge/model/house.dart';
import 'package:lodge/screen/detail/widget/content_intro.dart';
import 'package:lodge/screen/detail/widget/detail_app_bar.dart';
import 'package:lodge/screen/home/widget/about.dart';

class DetailPage extends StatefulWidget {
  final House house;

  DetailPage({super.key, required this.house});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool _isBooked = false;

  @override
  void initState() {
    super.initState();
    _loadBookingStatus(); // Load the booking status from SharedPreferences
  }

  // Load the booking status for this house
  Future<void> _loadBookingStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isBooked = prefs.getBool('${widget.house.name}_booked') ?? false; // Unique key based on house name
    });
  }

  // Save the booking status for this house
  Future<void> _saveBookingStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('${widget.house.name}_booked', true); // Save booking status
  }

  // Retrieve owner and buyer details from SharedPreferences
  Future<Map<String, String>> _retrieveUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String buyerName = prefs.getString('userName') ?? 'Lovely Customer';
    String ownerName = prefs.getString('ownerName') ?? 'Owner';
    String ownerContact = prefs.getString('ownerContact') ?? 'No Contact';
    return {'buyerName': buyerName, 'ownerName': ownerName, 'ownerContact': ownerContact};
  }

  // Function to store notifications in SharedPreferences
  Future<void> _addNotification(String message) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? notifications = prefs.getStringList('notifications') ?? [];
    String timestamp = DateTime.now().toLocal().toString();
    notifications.add('$timestamp: $message');

    await prefs.setStringList('notifications', notifications);
  }

  void _bookHouse(BuildContext context) async {
    final userDetails = await _retrieveUserDetails();
    String buyerName = userDetails['buyerName']!;
    String ownerName = userDetails['ownerName']!;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Book House'),
          content: Text('Are you sure you want to book ${widget.house.name}?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Confirm'),
              onPressed: () async {
                Navigator.of(context).pop();

                // Send buyer and owner notifications
                String buyerNotification =
                    'Hello $buyerName! Owner will be notified and you will be contacted soon!!';
                String ownerNotification =
                    'Hello $ownerName! Your apartment ${widget.house.name} has been booked by $buyerName. Kindly contact buyer for final negotiations.';

                await _addNotification(buyerNotification); // For buyer
                await _addNotification(ownerNotification); // For owner

                setState(() {
                  _isBooked = true; // Mark the house as booked
                });

                await _saveBookingStatus(); // Save booking status

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${widget.house.name} has been booked! Notification sent to owner.')),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DetailAppBar(house: widget.house),
            const SizedBox(height: 20),
            ContentIntro(house: widget.house),
            const SizedBox(height: 20),
            const About(),
            const SizedBox(height: 25),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                onPressed: _isBooked ? null : () => _bookHouse(context), // Disable button if booked
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: _isBooked ? Colors.grey : Colors.blue, // Grey if booked
                ),
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    _isBooked ? 'Booked' : 'Book Now', // Change text if booked
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
