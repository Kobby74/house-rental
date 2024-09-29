import 'dart:convert';  
import 'package:flutter/material.dart';  
import 'package:lodge/model/house.dart';  
import 'package:lodge/screen/detail/detail.dart';  
import 'package:lodge/screen/home/widget/search_input.dart';  
import 'package:http/http.dart' as http;  

class SearchPage extends StatefulWidget {  
  const SearchPage({super.key});  

  @override  
  _SearchPageState createState() => _SearchPageState();  
}  

class _SearchPageState extends State<SearchPage> {  
  List<House> houses = []; // List to hold all houses  
  List<House> searchResults = []; // List to hold search results  
  bool isLoading = false; // Loading state indicator  

  @override  
  void initState() {  
    super.initState();  
    fetchHouses(); // Fetch houses upon initialization  
  }  

  // Fetch all houses from the API  
  Future<void> fetchHouses() async {  
    try {  
      setState(() {  
        isLoading = true;  
      });  
      var url = Uri.parse('https://rentapp-api.drevap.com/api/property/');  
      var response = await http.get(url);  
      if (response.statusCode == 200) {  
        var data = jsonDecode(response.body);  
        if (data is List) {  
          setState(() {  
            houses = data.map((json) => House.fromJson(json)).toList();  
            searchResults = houses; // Initially show all houses  
            isLoading = false;  
          });  
        } else if (data is Map && data['data'] != null && data['data'] is List) {  
          setState(() {  
            houses = (data['data'] as List).map((json) => House.fromJson(json)).toList();  
            searchResults = houses; // Show the retrieved houses  
            isLoading = false;  
          });  
        }  
      } else {  
        ScaffoldMessenger.of(context).showSnackBar(  
          SnackBar(content: Text('Failed to load properties. Status code: ${response.statusCode}')),  
        );  
      }  
    } catch (e) {  
      ScaffoldMessenger.of(context).showSnackBar(  
        SnackBar(content: Text('An error occurred: $e')),  
      );  
    } finally {  
      setState(() {  
        isLoading = false; // Stop loading regardless of success or failure  
      });  
    }  
  }  

  // Handle search input  
  void _handleSearch(String query) {  
    if (query.isNotEmpty) {  
      setState(() {  
        searchResults = houses.where((house) {  
          return house.name.toLowerCase().contains(query.toLowerCase()) ||  
              house.location.toLowerCase().contains(query.toLowerCase());  
        }).toList();  
      });  
    } else {  
      setState(() {  
        searchResults = houses; // Reset to show all houses if no query  
      });  
    }  
  }  

  @override  
  Widget build(BuildContext context) {  
    return Scaffold(  
      appBar: AppBar(  
        title: const Text('Search Houses'),  
      ),  
      body: Column(  
        children: [  
          SearchInput(onSearch: _handleSearch),  
          if (isLoading)  
            const Center(child: CircularProgressIndicator())  
          else   
            Expanded(  
              child: ListView.builder(  
                itemCount: searchResults.length,  
                itemBuilder: (context, index) {  
                  final house = searchResults[index];  
                  return Card(  
                    margin: const EdgeInsets.all(10),  
                    child: ListTile(  
                      contentPadding: const EdgeInsets.all(10),  
                      leading: house.imageUrl.isNotEmpty  
                          ? Image.network(house.imageUrl, width: 50, height: 50, fit: BoxFit.cover)  
                          : const Icon(Icons.image_not_supported), // Fallback if there's no image  
                      title: Text(house.name),  
                      subtitle: Column(  
                        crossAxisAlignment: CrossAxisAlignment.start,  
                        children: [  
                          Text(house.location),  
                          Text(house.description),  
                          Text(house.price),  
                        ],  
                      ),  
                      onTap: () {  
                        Navigator.of(context).push(MaterialPageRoute(  
                          builder: (context) => DetailPage(house: house),  
                        ));  
                      },  
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