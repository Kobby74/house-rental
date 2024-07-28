import 'package:flutter/material.dart';
import 'package:lodge/model/house.dart';
import 'package:lodge/screen/home/widget/search_input.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<House> houses = House.generateRecommended();
  List<House> searchResults = [];

  void _handleSearch(String query) {
    setState(() {
      searchResults = houses
          .where((house) => house.name.toLowerCase().contains(query.toLowerCase()) ||
              house.address.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Houses'),
      ),
      body: Column(
        children: [
          SearchInput(onSearch: _handleSearch),
          Expanded(
            child: ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                final house = searchResults[index];
                return Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(10),
                    leading: Image.asset(house.imageUrl, width: 50, height: 50, fit: BoxFit.cover),
                    title: Text(house.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(house.address),
                        Text(house.description),
                        Text(house.price),
                        Row(
                          children: [
                            house.buildBedroomIcon(),
                            SizedBox(width: 10),
                            house.buildKitchenIcon(),
                            SizedBox(width: 10),
                            house.buildBathroomIcon(),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
