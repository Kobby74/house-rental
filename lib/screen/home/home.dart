import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lodge/screen/home/widget/best_offer.dart';
import 'package:lodge/screen/home/widget/categories.dart';
import 'package:lodge/screen/home/widget/custom_app_bar.dart';
import 'package:lodge/screen/home/widget/custom_bottom_navigation.dart';
import 'package:lodge/screen/home/widget/recommended_house.dart';
import 'package:lodge/screen/home/widget/search_input.dart';
import 'package:lodge/screen/home/widget/welcom_text.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  final String role;

  HomePage({required this.role});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _houseNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _regionController = TextEditingController();
  final TextEditingController _townController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _gpsAddressController = TextEditingController();
  final TextEditingController _apartmentTypeController = TextEditingController();
  final TextEditingController _furnishingController = TextEditingController();
  final TextEditingController _buidingTypeController = TextEditingController();
  XFile? _image;

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
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
    String apartmentType = _apartmentTypeController.text.trim();
    String furnishing = _furnishingController.text.trim();
    String buildingType = _buidingTypeController.text.trim();

    if (houseName.isNotEmpty &&
        description.isNotEmpty &&
        price.isNotEmpty &&
        _image != null &&
        location.isNotEmpty &&
        region.isNotEmpty &&
        town.isNotEmpty &&
        country.isNotEmpty &&
        gpsAddress.isNotEmpty &&
        apartmentType.isNotEmpty &&
        furnishing.isNotEmpty &&
        buildingType.isNotEmpty) {
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

        var response = await http.post(
          url,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          body: body,
        );

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('House details uploaded successfully!')),
          );
          _houseNameController.clear();
          _descriptionController.clear();
          _priceController.clear();
          setState(() {
            _image = null;
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to upload details. Please try again.')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields and select an image')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: CustomAppBar('Home'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WelcomeText(),
            SearchInput(
              onSearch: (query) {
                print('Search query: $query');
              },
            ),
            Categories(),
            RecommendedHouse(),
            BestOffer(),
            if (widget.role == 'Owner') ...[
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Add Appartment'),
                        content: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
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
                              TextField(
                                controller: _apartmentTypeController,
                                decoration: InputDecoration(
                                  labelText: 'Apartment Type',
                                  hintText: 'Enter apartment type',
                                ),
                              ),
                              TextField(
                                controller: _furnishingController,
                                decoration: InputDecoration(
                                  labelText: 'Furnishing',
                                  hintText: 'Enter furnishing',
                                ),
                              ),
                              TextField(
                                controller: _buidingTypeController,
                                decoration: InputDecoration(
                                  labelText: 'Building Type',
                                  hintText: 'Enter building type',
                                ),
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
                            ],
                          ),
                        ),
                        actions: [
                          ElevatedButton(
                            onPressed: _uploadHouseDetails,
                            child: Text('Upload'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Cancel'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Text('Add Apartment'),
                ),
              ),
            ],
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
