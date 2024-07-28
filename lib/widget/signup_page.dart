import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  String _role = 'Buyer';

  void _signup() {
    String firstname = _firstnameController.text.trim();
    String lastname = _lastnameController.text.trim();
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();
    String email = _emailController.text.trim();
    String phoneNumber = _phoneNumberController.text.trim();

    print('Firstname: $firstname');
    print('Lastname: $lastname');
    print('Username: $username');
    print('Password: $password');
    print('Email: $email');
    if (_role == 'Owner') {
      print('Phone Number: $phoneNumber');
    }

    Navigator.pop(context);
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
              DropdownButtonFormField<String>(
                value: _role,
                dropdownColor: Color.fromARGB(255, 28, 22, 65), 
                style: TextStyle(color: Colors.white), 
                decoration: InputDecoration(
                  labelText: 'Owner/Buyer',
                  labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25
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
              if (_role == 'Owner') ...[
                SizedBox(height: 12.0),
                TextField(
                  controller: _phoneNumberController,
                  style: TextStyle(color: Colors.white),
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    hintText: 'Enter your phone number',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                ),
              ],
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

class OwnerHomePage extends StatefulWidget {
  @override
  _OwnerHomePageState createState() => _OwnerHomePageState();
}

class _OwnerHomePageState extends State<OwnerHomePage> {
  final TextEditingController _houseNameController = TextEditingController();
  final TextEditingController _houseDescriptionController = TextEditingController();
  final TextEditingController _houseLocationController = TextEditingController();
  List<Image> _houseImages = [];

  void _uploadHouseDetails() {
    String houseName = _houseNameController.text.trim();
    String houseDescription = _houseDescriptionController.text.trim();
    String houseLocation = _houseLocationController.text.trim();

    print('House Name: $houseName');
    print('House Description: $houseDescription');
    print('House Location: $houseLocation');
    print('House Images: $_houseImages');

    // You can add your logic to save the details to a database or server here.
  }

  void _pickImage() async {
    // Use image picker to select images
    // This is a placeholder for the image picking logic.
    // You can use the image_picker package to implement this.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload House Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _houseNameController,
                decoration: InputDecoration(
                  labelText: 'House Name',
                  hintText: 'Enter the house name',
                ),
              ),
              SizedBox(height: 12.0),
              TextField(
                controller: _houseDescriptionController,
                decoration: InputDecoration(
                  labelText: 'House Description',
                  hintText: 'Enter the house description',
                ),
              ),
              SizedBox(height: 12.0),
              TextField(
                controller: _houseLocationController,
                decoration: InputDecoration(
                  labelText: 'House Location',
                  hintText: 'Enter the house location',
                ),
              ),
              SizedBox(height: 12.0),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Pick House Images'),
              ),
              SizedBox(height: 12.0),
              Wrap(
                spacing: 10.0,
                runSpacing: 10.0,
                children: _houseImages.map((image) {
                  return Container(
                    width: 100.0,
                    height: 100.0,
                    child: image,
                  );
                }).toList(),
              ),
              SizedBox(height: 12.0),
              ElevatedButton(
                onPressed: _uploadHouseDetails,
                child: Text('Upload House Details'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
