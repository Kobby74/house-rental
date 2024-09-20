import "package:flutter/material.dart";
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AddApartment extends StatefulWidget {
  const AddApartment({super.key});

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
  var imageUrl;
  final List<String> _furnishing = [
    'Furnished',
    'Semi-furnished',
    'Not Furnished'
  ];

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) {
      print('No image selected.');
      return;
    }
    setState(() {
      _image = image;
    });
    print('Image path: ${_image!.path}');
    imageUrl = await _uploadImage(File(_image!.path));
    print(imageUrl);
  }

  Future<String?> _uploadImage(File imageFile) async {
    try{
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://rentapp-api.drevap.com/api/property/upload'),
    );
    request.files
        .add(await http.MultipartFile.fromPath('images[]', imageFile.path));

    var response = await request.send();
    if (response.statusCode == 200) {
      var responseData = await response.stream.bytesToString();
      var jsonResponse = jsonDecode(responseData);
      print(jsonResponse['data']);
      return jsonResponse['data'];
    } else {
         print('Failed to upload image. Status code: ${response.statusCode}');
      return null;
    }
    } catch (e) {
        print('Error during image upload: $e');
        return null;
  }

  }

  void _uploadHouseDetails() async {
    if (_image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an image')),
      );
      return;
    }

    if (imageUrl == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Failed to upload image. Please try again.')),
      );
      return;
    }

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
          "isNegotiable": "1",
          "isRenting": "1",
          "isSelling": "0",
          "isActive": "1",
          "image_urls": imageUrl,
        });

        var response = await http.post(
          url,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          body: body,
        );
        print('Add Property Status Code: ${response.statusCode}');
        print('Add Property Response Body: ${response.body}');

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('House details uploaded successfully!')),
          );

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
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content:
                    Text('Failed to upload house details. Please try again.')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please fill all fields and select an image')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Apartment')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _houseNameController,
              decoration: const InputDecoration(
                labelText: 'House Name',
                hintText: 'Enter house name',
              ),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                hintText: 'Enter house description',
              ),
              maxLines: 3,
            ),
            TextField(
              controller: _priceController,
              decoration: const InputDecoration(
                labelText: 'Price',
                hintText: 'Enter house price',
              ),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _locationController,
              decoration: const InputDecoration(
                labelText: 'Location',
                hintText: 'Enter house location',
              ),
            ),
            TextField(
              controller: _regionController,
              decoration: const InputDecoration(
                labelText: 'Region',
                hintText: 'Enter house region',
              ),
            ),
            TextField(
              controller: _townController,
              decoration: const InputDecoration(
                labelText: 'Town',
                hintText: 'Enter town',
              ),
            ),
            TextField(
              controller: _countryController,
              decoration: const InputDecoration(
                labelText: 'Country',
                hintText: 'Enter country',
              ),
            ),
            TextField(
              controller: _gpsAddressController,
              decoration: const InputDecoration(
                labelText: 'GPS Address',
                hintText: 'Enter GPS address',
              ),
            ),
            DropdownButtonFormField<String>(
              value: _selectedApartmentType,
              onChanged: (newValue) {
                setState(() {
                  _selectedApartmentType = newValue;
                });
              },
              items: [
                'single room',
                'single room self contain',
                'chamber and hall',
                '2 bedroom',
                'studio',
                'micro',
                'duplex',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: const InputDecoration(
                labelText: 'Apartment Type',
              ),
            ),
            DropdownButtonFormField<String>(
              value: _selectedBuildingType,
              onChanged: (newValue) {
                setState(() {
                  _selectedBuildingType = newValue;
                });
              },
              items: [
                'compound house',
                'flat',
                '2 storey',
                '1 storey',
                'other',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: const InputDecoration(
                labelText: 'Building Type',
              ),
            ),
            DropdownButton<String>(
              value: _selectedFurnishing,
              hint: const Text('Select Furnishing'),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedFurnishing = newValue!;
                });
              },
              items: _furnishing.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 10.0),
            _image == null
                ? const Text('No image selected.')
                : Image.file(File(_image!.path)),
            const SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: pickImage,
              child: const Text('Pick Image'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _uploadHouseDetails,
              child: const Text('Upload'),
            ),
          ],
        ),
      ),
    );
  }
}
