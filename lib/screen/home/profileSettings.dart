import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfileSettingsPage extends StatefulWidget {
  const ProfileSettingsPage({super.key});

  @override
  _ProfileSettingsPageState createState() => _ProfileSettingsPageState();
}

class _ProfileSettingsPageState extends State<ProfileSettingsPage> {
  String? _name;
  String? _email;
  String? _phone;
  String? _avatarPath;
  File? _avatar;
  String? _storedPassword; // For storing the old password from SharedPreferences
  String? _token;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _oldPasswordController = TextEditingController(); // Old Password input
  final TextEditingController _newPasswordController = TextEditingController(); // New Password input

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  // Load user data and password from SharedPreferences
  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString('userName') ?? 'Unknown';
      _email = prefs.getString('email') ?? 'No email found';
      _phone = prefs.getString('phoneNumber') ?? 'No phone number found';
      _avatarPath = prefs.getString('avatarPath');
      _storedPassword = prefs.getString('password'); // Load the stored password from SharedPreferences
      _token = prefs.getString('access_token');

      _nameController.text = _name ?? '';
      _emailController.text = _email ?? '';
      _phoneController.text = _phone ?? '';

      if (_avatarPath != null) {
        _avatar = File(_avatarPath!);
      }
    });
  }

  // Update user details via API, after validating the old password locally
  Future<void> _updateProfile() async {
    String oldPassword = _oldPasswordController.text.trim();
    String newPassword = _newPasswordController.text.trim();

    // Check if the old password matches with the stored password in SharedPreferences
    if (oldPassword.isEmpty || oldPassword != _storedPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Old password is incorrect!')),
      );
      return;
    }

    if (newPassword.isNotEmpty && oldPassword == newPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('New password cannot be the same as the old password.')),
      );
      return;
    }

    if (_token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error: User is not authenticated')),
      );
      return;
    }

    // API call to update user details
    var url = Uri.parse('https://rentapp-api.drevap.com/api/user/update');
    var body = jsonEncode({
      'name': _nameController.text,
      'email': _emailController.text,
      'phone': _phoneController.text,
      if (newPassword.isNotEmpty) 'password': newPassword, // Update the password if provided
    });

    var response = await http.patch(
      url,
      headers: {
        'Authorization': 'Bearer $_token',
        'Content-Type': 'application/json',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully!')),
      );

      // Save the updated details in SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('userName', _nameController.text);
      await prefs.setString('email', _emailController.text);
      await prefs.setString('phoneNumber', _phoneController.text);

      if (newPassword.isNotEmpty) {
        await prefs.setString('password', newPassword); // Update the stored password
      }

      if (_avatar != null) {
        await prefs.setString('avatarPath', _avatarPath!);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update profile. Error: ${response.body}')),
      );
    }
  }

  // Change avatar and store the path in SharedPreferences
  Future<void> _changeAvatar() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _avatar = File(image.path);
        _avatarPath = image.path;
      });

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('avatarPath', _avatarPath!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Settings'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: _changeAvatar, // Allow user to change avatar on tap
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _avatar != null
                    ? FileImage(_avatar!) as ImageProvider
                    : const AssetImage('assets/images/default_avatar.png'),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: 'Phone'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _oldPasswordController,
              decoration: const InputDecoration(labelText: 'Old Password'),
              obscureText: true,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _newPasswordController,
              decoration: const InputDecoration(labelText: 'New Password'),
              obscureText: true,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _updateProfile, // API call to update profile
              child: const Text('Update Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
