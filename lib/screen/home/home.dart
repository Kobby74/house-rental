import 'package:flutter/material.dart';
import 'package:lodge/screen/home/add_apartment.dart';
import 'package:lodge/screen/home/widget/best_offer.dart';
import 'package:lodge/screen/home/widget/categories.dart';
import 'package:lodge/screen/home/widget/custom_app_bar.dart';
import 'package:lodge/screen/home/widget/custom_bottom_navigation.dart';
import 'package:lodge/screen/home/widget/recommended_house.dart';
import 'package:lodge/screen/home/widget/search_input.dart';
import 'package:lodge/screen/home/widget/welcom_text.dart';

class HomePage extends StatefulWidget {
  final String role;
  final String username;

  const HomePage({super.key, required this.role, required this.username});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;

  Future<void> _fetchRecommendedHouses() async {
    await Future.delayed(const Duration(seconds: 2));
  }

  Future<void> _fetchBestOffers() async {
    await Future.delayed(const Duration(seconds: 2));
  }

  Future<void> _refreshPage() async {
    setState(() {
      isLoading = true;
    });
    await Future.wait([
      _fetchRecommendedHouses(),
      _fetchBestOffers(),
    ]);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const CustomAppBar('Home'),
      body: RefreshIndicator(
        onRefresh: _refreshPage,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              WelcomeText(username: widget.username),
              SearchInput(
                onSearch: (query) {
                  print('Search query: $query');
                },
              ),
              const Categories(),
              const RecommendedHouse(),
              const BestOffer(),
              
              if (widget.role == 'Owner') ...[
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AddApartment()),
                      );
                    },
                    child: const Text('Add Apartment'),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
      bottomNavigationBar:  CustomBottomNavigationBar(),
    );
  }
}
