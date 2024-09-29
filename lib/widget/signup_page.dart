import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignupPage extends StatefulWidget {
  final Function(String, String) onSignup;
  const SignupPage({super.key, required this.onSignup});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  bool _obscurePassword = true;
  String _errorMessage = '';
  String loading = 'Sign Up';

  void _signup() async {
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();
    String email = _emailController.text.trim();
    String phonenumber = _phoneController.text.trim();

    if (username.isNotEmpty && password.isNotEmpty && email.isNotEmpty) {
      var url = Uri.parse('https://rentapp-api.drevap.com/api/auth/register');

      var body = jsonEncode({
        'name': username,
        'password': password,
        'email': email,
        'msisdn': phonenumber,
      });

      setState(() {
        loading = 'Signing Up...';
      });

      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: body,
      );

      if (response.statusCode == 200) {
        widget.onSignup(username, password);
        Navigator.pop(context);
      } else {
        final rest = response.body;
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        setState(() {
          loading = 'Retry';
          _errorMessage = responseBody['message'];
        });
        print('Signup failed with status: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } else {
      setState(() {
        _errorMessage = "Please fill in all your details";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up📝'),
        titleTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
          color: Color.fromARGB(255, 250, 147, 181)),
        backgroundColor: const Color.fromARGB(255, 28, 22, 65),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/city4.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 12.0),
              TextField(
                controller: _usernameController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Name',
                  labelStyle: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
                  hintText: 'Create a name',
                  hintStyle: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 12.0),
              TextField(
                controller: _passwordController,
                style: const TextStyle(color: Colors.white),
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
                  hintText: 'Enter your password',
                  hintStyle: const TextStyle(color: Colors.white),
                  suffixIcon: IconButton(
                    icon: SvgPicture.asset(
                      _obscurePassword
                      ? 'assets/icons/eye-slash-alt-svgrepo-com.svg' : 'assets/icons/eye-svgrepo-com.svg',
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 12.0),
              TextField(
                controller: _emailController,
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
                  hintText: 'Enter your email',
                  hintStyle: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 12.0),
              TextField(
                controller: _phoneController,
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  labelStyle: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
                  hintText: 'Enter your phone number',
                  hintStyle: TextStyle(color: Colors.white),
                ),
              ),
              Text(
                _errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
              const SizedBox(height: 12.0),
              ElevatedButton(
                onPressed: _signup,
                child: Text(loading),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
