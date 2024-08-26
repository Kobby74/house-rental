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

class  HomePage extends StatelessWidget {
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
  final TextEditingController _hController = TextEditingController();
  final TextEditingController _houseNameController = TextEditingController();
  final TextEditingController _houseNameController = TextEditingController();
  final TextEditingController _houseNameController = TextEditingController();
  final TextEditingController _houseNameController = TextEditingController();
}