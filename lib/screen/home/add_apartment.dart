import "package:flutter/material.dart";
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:http/http.dart'as http;

class AddApartment extends StatefulWidget{
@override
_AddApartmentState createState() => _AddApartmentState();
}

class _AddApartmentState extends State<AddApartment> {
    final TextEditingController _houseNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _regionController = TextEditingController();
  final TextEditingController _townController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _gpsAddressController = TextEditingController();
  XFile? _image;

  String? _selectedBuildingType;
  String? _selectedApartmentType;
  String? _selectedFurnishing;

  final List<String> _buildingTypes = ['Compund House','Flat','1 Storey','2 Storey','Other'];
  final List<String> _apartmentTypes = ['single room','single room self contain','Chamber and Hall',
  '2 bedroom','Studio','Micro','duplex'];
  final List<String> _furnishing = ['Fully Furnished','Semi-furnished','Not Furnished'];

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    setState((){
      _image = image;
    });
  }

  void _uploadHouseDetails() async {
    String houseName = _houseNameController.text.trim();
    String description = _descriptionController.text.trim();
    String price = _priceController.text.trim();
    String location = _locationController.text.trim();
    String region = _regionController.text.trim();
    String town = _townController.text.trim();
    String country = _countryController.text.trim();
    String gpsAddress = _gpsAddressController.text.trim();
    String? buildingType = _selectedBuildingType;
    String? apartmentType = _selectedApartmentType;
    String? furnishing = _selectedFurnishing;

     if (houseName.isNotEmpty &&
        description.isNotEmpty &&
        price.isNotEmpty &&
        _image != null &&
        location.isNotEmpty &&
        region.isNotEmpty &&
        town.isNotEmpty &&
        country.isNotEmpty &&
        gpsAddress.isNotEmpty && 
        buildingType != null && 
        apartmentType != null && 
        furnishing != null) {
          try {
            var url = Uri.parse('https://rentapp-api.drevap.com/api/property/add');

            var body = jsonEncode({
          "name": houseName,
          "description": description,
          "location": location,
          "region": region,
          "town": town,
          "country": country,
          "gpsAddress": gpsAddress,
          "apartmentType": apartmentType,
          "buildingType": buildingType,
          "furnishing": furnishing,
          "price": price,
            });

            var response = await http.post(url,
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: body,
            
            );
            print('Status Code: ${response.statusCode}');
            print('Response Body: ${response.body}');

            if (response.statusCode == 200) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('House details uploaded successfully!')),);

          _houseNameController.clear();
          _descriptionController.clear();
          _priceController.clear();
          _locationController.clear();
          _regionController.clear();
          _townController.clear();
          _countryController.clear();
          _gpsAddressController.clear();

          setState(() {
            _selectedBuildingType = null;
            _selectedApartmentType = null;
            _selectedFurnishing = null;
            _image = null;
          });
            } else{
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to upload house details. Please try again.')),
              );
            }
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('An error occured: $e')),
            );
          }
        } else{
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please fill all fields and select an image')),
          );
        }
  }
  @override
    Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Apartment'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _houseNameController,
                decoration: InputDecoration(
                  labelText: 'House Name',
                  hintText: 'Enter house name',
                ),
              ),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  hintText: 'Enter house description',
                ),
                maxLines: 3,
              ),
              TextField(
                controller: _priceController,
                decoration: InputDecoration(
                  labelText: 'Price',
                  hintText: 'Enter house price',
                ),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _locationController,
                decoration: InputDecoration(
                  labelText: 'Location',
                  hintText: 'Enter house location',
                ),
              ),
              TextField(
                controller: _regionController,
                decoration: InputDecoration(
                  labelText: 'Region',
                  hintText: 'Enter house region',
                ),
              ),
              TextField(
                controller: _townController,
                decoration: InputDecoration(
                  labelText: 'Town',
                  hintText: 'Enter town',
                ),
              ),
              TextField(
                controller: _countryController,
                decoration: InputDecoration(
                  labelText: 'Country',
                  hintText: 'Enter country',
                ),
              ),
              TextField(
                controller: _gpsAddressController,
                decoration: InputDecoration(
                  labelText: 'GPS Address',
                  hintText: 'Enter GPS address',
                ),
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Apartment Type',
                  hintText: 'Enter apartment type',
                ),
                value: _selectedBuildingType,
                items: _buildingTypes.map((String value){
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState((){
                    _selectedBuildingType = newValue;
                  });
                },
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Furnishing',
                  hintText: 'Enter furnishing',
                ),
                value: _selectedApartmentType,
                items: _apartmentTypes.map((String value){
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState((){
                    _selectedApartmentType = newValue;
                  });
                },
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Building Type',
                  hintText: 'Enter building type',
                ),
                value: _selectedFurnishing,
                items: _furnishing.map((String value){
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue){
                  setState((){
                    _selectedFurnishing = newValue;
                  });
                },
              ),
              SizedBox(height: 10.0),
              _image == null
                  ? Text('No image selected.')
                  : Image.file(File(_image!.path)),
              SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: pickImage,
                child: Text('Pick Image'),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _uploadHouseDetails,
                child: Text('Upload'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}