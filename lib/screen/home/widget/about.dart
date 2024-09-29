import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  String ownerName = 'Loading...';
  String contact = 'Loading...';

  // Function to retrieve owner details from SharedPreferences
  Future<void> _retrieveOwnerDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      ownerName = prefs.getString('name') ?? 'Unknown Owner';
      contact = prefs.getString('phoneNumber') ?? 'No Contact Available';
    });
  }

  @override
  void initState() {
    super.initState();
    _retrieveOwnerDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20,),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
              fontSize: 20, 
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Owner: $ownerName \nContact: $contact',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontSize: 16,
              color: Colors.black26,
            ),
          ),
        ],
      ),
    );
  }
}
