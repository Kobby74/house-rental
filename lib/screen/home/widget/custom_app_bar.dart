import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lodge/login_page.dart';
import 'package:lodge/screen/home/profileSettings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar(this.title, {super.key});

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(50);
}

class _CustomAppBarState extends State<CustomAppBar> {
  String? _avatarPath; // To store the path of the avatar

  @override
  void initState() {
    super.initState();
    _loadAvatar(); // Load the avatar when the widget is initialized
  }

  // Method to load avatar path from SharedPreferences
  Future<void> _loadAvatar() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _avatarPath = prefs.getString('avatarPath'); // Load avatar path
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PopupMenuButton<String>(
              icon: SvgPicture.asset('assets/icons/menu-svgrepo-com.svg'),
              onSelected: (value) {
                if (value == 'logout') {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                } else {
                  print(value);
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'recommended',
                  child: Text('Recommended'),
                ),
                const PopupMenuItem<String>(
                  value: 'near_you',
                  child: Text('Near You'),
                ),
                const PopupMenuItem<String>(
                  value: 'best_offer',
                  child: Text('Best Offer'),
                ),
                const PopupMenuItem<String>(
                  value: 'agency_recommended',
                  child: Text('Agency Recommended'),
                ),
                const PopupMenuDivider(),
                const PopupMenuItem<String>(
                  value: 'logout',
                  child: Text('Logout'),
                ),
              ],
            ),
            Text(widget.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfileSettingsPage()),
                );
              },
              child: CircleAvatar(
                radius: 20,
                backgroundImage: _avatarPath != null
                    ? FileImage(File(_avatarPath!)) as ImageProvider
                    : const AssetImage('assets/images/default_avatar.png'), // Display avatar or default image
              ),
            ),
          ],
        ),
      ),
    );
  }
}
