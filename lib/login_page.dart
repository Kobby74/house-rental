import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:lodge/screen/home/home.dart';
import 'package:lodge/widget/signup_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';
  String _role = 'Buyer'; // Default role is Buyer
  String loading = 'Login';
  bool _obscurePassword = true;

  void _login() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isNotEmpty && password.isNotEmpty) {
      var url = Uri.parse('https://rentapp-api.drevap.com/api/auth/login');

      var body = jsonEncode({
        'email': email,
        'password': password,
      });

      setState(() {
        loading = 'Loading...';
      });

      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        // Parse the response body
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        print('Response body: ${response.body}');

        // Extract the token, name, and phone number from responseBody
        String token = responseBody['data']['access_token'];
        String name = responseBody['data']['userData']['name'];
        String phoneNumber = responseBody['data']['userData']['msisdn'];
        String email = responseBody['data']['userData']['email'];
        String userRole = _role;// Role is selected from the dropdown

        // Store the token, name, role, and phone number using SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('access_token', token);
        await prefs.setString('userName', name);
        await prefs.setString('phoneNumber', phoneNumber);
        await prefs.setString('email', email);
        await prefs.setString('userRole', userRole); // Store the role
        await prefs.setString('password', password);

        // Navigate to the HomePage with role, name, and phone number
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(
              role: _role,
              name: name,
              phoneNumber: phoneNumber,
            ),
          ),
        );
      } else {
        setState(() {
          loading = 'Retry';
          _errorMessage = 'Invalid email or password. Please try again.';
        });
      }
    } else {
      setState(() {
        _errorMessage = 'Please fill in both fields';
      });
    }
  }

  void _navigateToSignup() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SignupPage(onSignup: (email, password) {
          setState(() {});
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WELCOME TO LODGE🏡'),
        titleTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
          color: Color.fromARGB(255, 250, 147, 181),
        ),
        backgroundColor: const Color.fromARGB(255, 28, 22, 65),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/city4.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButtonFormField<String>(
                  value: _role,
                  dropdownColor: const Color.fromARGB(255, 28, 22, 65),
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Select Role',
                    labelStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  items: ['Buyer', 'Owner'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _role = newValue!;
                    });
                  },
                ),
                const SizedBox(height: 20.0),
                TextField(
                  controller: _emailController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: 'Enter your email',
                    hintStyle: TextStyle(
                      color: Color.fromARGB(255, 250, 250, 250),
                    ),
                    labelText: 'Email',
                    labelStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                TextField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Enter your password',
                    hintStyle: const TextStyle(color: Colors.white),
                    labelText: 'Password',
                    labelStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    suffixIcon: IconButton(
                      icon: SvgPicture.asset(
                        _obscurePassword
                            ? 'assets/icons/eye-slash-alt-svgrepo-com.svg'
                            : 'assets/icons/eye-svgrepo-com.svg',
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
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: _login,
                  child: Text(loading),
                ),
                const SizedBox(height: 10.0),
                Text(
                  _errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: _navigateToSignup,
                  child: const Text('Sign Up'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}