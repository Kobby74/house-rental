import 'package:flutter/material.dart';
import 'package:lodge/screen/home/widget/best_offer.dart';
import 'package:lodge/screen/home/widget/categories.dart';
import 'package:lodge/screen/home/widget/custom_app_bar.dart';
import 'package:lodge/screen/home/widget/custom_bottom_navigation.dart';
import 'package:lodge/screen/home/widget/recommended_house.dart';
import 'package:lodge/screen/home/widget/search_input.dart';
import 'package:lodge/screen/home/widget/welcom_text.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
       appBar:   CustomAppBar('Home'),
      body:   SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           WelcomeText(),
           SearchInput(onSearch: (query) {
                print('Search query: $query');
              },),
           Categories(),
          RecommendedHouse(),
          BestOffer(),
        ],),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}