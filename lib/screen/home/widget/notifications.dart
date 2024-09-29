import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<Map<String, String>> notifications = []; // List to hold notifications with timestamps
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadNotifications(); // Load notifications from shared prefs
  }

  // Load notifications from SharedPreferences
  Future<void> _loadNotifications() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? storedNotifications = prefs.getStringList('notifications');
    
    if (storedNotifications != null) {
      setState(() {
        notifications = storedNotifications
            .map((notification) {
              final parts = notification.split('|');
              return {
                'message': parts[0], // Notification message
                'timestamp': parts[1], // Timestamp
              };
            }).toList();
        isLoading = false;
      });
    } else {
      setState(() {
        notifications = [];
        isLoading = false;
      });
    }
  }

  // Function to show notification details in a dialog
  void _showNotificationDetails(String message, String timestamp) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Notification Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(message),
              const SizedBox(height: 10),
              Text(
                timestamp,
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: Colors.blueAccent,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : notifications.isEmpty
              ? const Center(child: Text('No notifications available'))
              : ListView.builder(
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    final notification = notifications[index];
                    return ListTile(
                      leading: const Icon(Icons.notifications, color: Colors.blueAccent),
                      title: Text(notification['message']!),
                      subtitle: Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          notification['timestamp']!, // Display timestamp
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ),
                      onTap: () {
                        // Show notification details when tapped
                        _showNotificationDetails(notification['message']!, notification['timestamp']!);
                      },
                    );
                  },
                ),
    );
  }
}
