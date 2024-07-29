import 'package:flutter/material.dart';
import 'package:lodge/screen/home/home.dart';

class SignupPage extends StatefulWidget {
  final Function(String, String) onSignup;

  SignupPage({required this.onSignup});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  void _signup() {
    String firstname = _firstnameController.text.trim();
    String lastname = _lastnameController.text.trim();
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();
    String email = _emailController.text.trim();

    if (username.isNotEmpty && password.isNotEmpty) {
      widget.onSignup(username, password);

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up📝'),
        titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Color.fromARGB(255, 250, 147, 181)),
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
              TextField(
                controller: _firstnameController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'First Name',
                  labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  hintText: 'Enter your firstname',
                  hintStyle: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 12.0),
              TextField(
                controller: _lastnameController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Last Name',
                  labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  hintText: 'Enter your lastname',
                  hintStyle: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 12.0),
              TextField(
                controller: _usernameController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Username',
                  labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  hintText: 'Create a username',
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
                  labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
                  labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  hintText: 'Enter your email',
                  hintStyle: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 12.0),
              ElevatedButton(
                onPressed: _signup,
                child: Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
