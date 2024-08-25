import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignupPage extends StatefulWidget {
  final Function(String, String) onSignup;

  SignupPage({required this.onSignup});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String _errorMessage = '';
  String loading = 'Sign Up';

  void _signup() async {
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();
    String email = _emailController.text.trim();

    if (username.isNotEmpty && password.isNotEmpty && email.isNotEmpty) {
      var url = Uri.parse('https://rentapp-api.drevap.com/api/auth/register');

      var body = jsonEncode({
        'name': username,
        'password': password,
        'email': email,
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
        final rest = await response.body;
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        setState(() {
        loading = 'retry';
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
        title: Text('Sign Up📝'),
        titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Color.fromARGB(255, 250, 147, 181)),
        backgroundColor: Color.fromARGB(255, 28, 22, 65),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/city4.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 12.0),
              TextField(
                controller: _usernameController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'name',
                  labelStyle: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  hintText: 'Create a name',
                  hintStyle: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 12.0),
              TextField(
                controller: _passwordController,
                style: TextStyle(color: Colors.white),
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  hintText: 'Enter your password',
                  hintStyle: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 12.0),
              TextField(
                controller: _emailController,
                style: TextStyle(color: Colors.white),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  hintText: 'Enter your email',
                  hintStyle: TextStyle(color: Colors.white),
                ),
              ),
              Text(
                _errorMessage,
                style: TextStyle(color: Colors.red),
              ),
              SizedBox(height: 12.0),
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
