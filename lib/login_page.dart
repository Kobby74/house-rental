import 'package:flutter/material.dart';  
import 'package:lodge/screen/home/home.dart';  
import 'package:lodge/widget/signup_page.dart';

class LoginPage extends StatefulWidget {  
  @override  
  _LoginPageState createState() => _LoginPageState();  
}  

class _LoginPageState extends State<LoginPage> {  
  final TextEditingController _usernameController = TextEditingController();  
  final TextEditingController _passwordController = TextEditingController();  
  String _errorMessage = '';  
  String _role = 'Buyer';

  void _login() {  
    String username = _usernameController.text.trim();  
    String password = _passwordController.text.trim();  
  
    if (username == 'admin' && password == 'password') {  
      // Here you can navigate to different pages based on the selected role
      if (_role == 'Owner') {
        Navigator.pushReplacement(  
          context,  
          MaterialPageRoute(builder: (context) => OwnerHomePage()),  
        );
      } else {
        Navigator.pushReplacement(  
          context,  
          MaterialPageRoute(builder: (context) => HomePage()),  
        );
      }
    } else {  
      setState(() {  
        _errorMessage = 'Invalid username or password. Please try again.';  
      });  
    }  
  }  

  void _navigateToSignup() {    
    Navigator.push(  
      context,  
      MaterialPageRoute(builder: (context) => SignupPage()),  
    );  
  }  

  @override  
  Widget build(BuildContext context) {  
    return Scaffold(  
      appBar: AppBar(  
        title: Text('WELCOME TO LODGE🏡'),
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
        child: Center(  
          child: Padding(  
            padding: EdgeInsets.all(20.0),  
            child: Column(  
              mainAxisAlignment: MainAxisAlignment.center,  
              children: [  
                DropdownButtonFormField<String>(
                  value: _role,
                  dropdownColor: Color.fromARGB(255, 28, 22, 65), // Set the dropdown background color
                  style: TextStyle(color: Colors.white), // Set the dropdown text color
                  decoration: InputDecoration(
                    labelText: 'Select Role',
                    labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
                SizedBox(height: 20.0),
                TextField(  
                  controller: _usernameController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(  
                    hintText: 'Enter your username',
                    hintStyle: TextStyle(color: Colors.white),
                    labelText: 'Username',
                    labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),  
                ),  
                SizedBox(height: 20.0),  
                TextField(  
                  controller: _passwordController,  
                  obscureText: true,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(  
                    hintText: 'Enter your password',
                    hintStyle: TextStyle(color: Colors.white),
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    
                  ),  
                ),  
                SizedBox(height: 20.0),  
                ElevatedButton(  
                  onPressed: _login,  
                  child: Text('Login'),  
                ),  
                SizedBox(height: 10.0),  
                Text(  
                  _errorMessage,  
                  style: TextStyle(color: Colors.red),  
                ),  
                SizedBox(height: 20.0),  
                ElevatedButton(  
                  onPressed: _navigateToSignup,  
                  child: Text('SignUp'),  
                ),  
              ],  
            ),  
          ),  
        ),  
      ),  
    );  
  }  
}
