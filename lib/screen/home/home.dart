import 'package:flutter/material.dart';
import 'package:lodge/screen/home/add_apartment.dart';
import 'package:lodge/screen/home/widget/best_offer.dart';
import 'package:lodge/screen/home/widget/categories.dart';
import 'package:lodge/screen/home/widget/custom_app_bar.dart';
import 'package:lodge/screen/home/widget/custom_bottom_navigation.dart';
import 'package:lodge/screen/home/widget/recommended_house.dart';
import 'package:lodge/screen/home/widget/search_input.dart';
import 'package:lodge/screen/home/widget/welcom_text.dart';

class HomePage extends StatelessWidget {
  final String role;

  const HomePage({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const CustomAppBar('Home'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const WelcomeText(),
            SearchInput(
              onSearch: (query) {
                print('Search query: $query');
              },
            ),
            const Categories(),
            const RecommendedHouse(),
            const BestOffer(),
            if (role == 'Owner') ...[
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AddApartment()),
                    );
                  },
                  child: const Text('Add Apartment'),
                ),
              ),
            ],
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
