import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lodge/login_page.dart';

class OwnerHomePage extends StatefulWidget {
  @override
  _OwnerHomePageState createState() => _OwnerHomePageState();
}

class _OwnerHomePageState extends State<OwnerHomePage> {
  final TextEditingController _houseNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  XFile? _image;

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  void _uploadHouseDetails() {
    String houseName = _houseNameController.text.trim();
    String description = _descriptionController.text.trim();
    String price = _priceController.text.trim();

    if (houseName.isNotEmpty && description.isNotEmpty && price.isNotEmpty && _image != null) {

      print('House Name: $houseName');
      print('Description: $description');
      print('Price: $price');
      print('Image Path: ${_image!.path}');

      _houseNameController.clear();
      _descriptionController.clear();
      _priceController.clear();
      setState(() {
        _image = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('House details uploaded successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields and select an image')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add House for rent/sale'),
        leading: IconButton(
          icon: SvgPicture.asset('assets/icons/left-arrow22.svg',),
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginPage()),
            );
          },
        ),
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
          color: Color.fromARGB(255, 250, 147, 181),
        ),
        backgroundColor: Color.fromARGB(255, 28, 22, 65),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _houseNameController,
              decoration: InputDecoration(
                labelText: 'House Name',
                hintText: 'Enter house name',
              ),
            ),
            SizedBox(height: 10.0),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                hintText: 'Enter house description',
              ),
              maxLines: 3,
            ),
            SizedBox(height: 10.0),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(
                labelText: 'Price',
                hintText: 'Enter house price',
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10.0),
            _image == null
                ? Text('No image selected.')
                : Image.file(File(_image!.path)),
            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Pick Image'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _uploadHouseDetails,
              child: Text('Upload House Details'),
            ),
          ],
        ),
      ),
    );
  }
}
