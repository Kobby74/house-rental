import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lodge/model/house.dart';
import 'package:lodge/screen/detail/detail.dart';
import 'package:lodge/widget/circle_icon_button.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class RecommendedHouse extends StatefulWidget {
  const RecommendedHouse({super.key});
  @override
  _RecommendedHouseState createState() => _RecommendedHouseState();
}

class _RecommendedHouseState extends State<RecommendedHouse> {
  List<House> recommendedList = [];
  bool isLoading = false;
  final Set<int> bookmarkedSet = {};
  String? _role; // To store the role of the logged-in user

  @override
  void initState() {
    super.initState();
    _loadUserRole();
    fetchRecommendedHouses();
  }

  Future<void> _loadUserRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _role = prefs.getString('userRole') ?? 'Buyer'; // Default to Buyer if null
    });
  }

  Future<void> fetchRecommendedHouses() async {
    try {
      setState(() {
        isLoading = true;
      });
      var url = Uri.parse('https://rentapp-api.drevap.com/api/property/');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print('Response Body: ${response.body}');
        
        if (data is List) {
          setState(() {
            recommendedList = data.map((json) => House.fromJson(json)).toList();
            isLoading = false;
          });
        } else if (data is Map && data['data'] != null && data['data'] is List) {
          setState(() {
            recommendedList = (data['data'] as List)
                .map((json) => House.fromJson(json))
                .toList();
            isLoading = false;
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Unexpected data format.')),
          );
          setState(() {
            isLoading = false;
          });
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load properties. Status code: ${response.statusCode}')),
        );
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  // Function to toggle bookmarks
  void _toggleBookmark(int index) {
    setState(() {
      if (bookmarkedSet.contains(index)) {
        bookmarkedSet.remove(index);
      } else {
        bookmarkedSet.add(index);
      }
    });
  }

  // Function to delete property
  Future<void> _deleteProperty(int id, int index) async {
    try {
      var url = Uri.parse('https://rentapp-api.drevap.com/api/property/delete/$id');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('access_token');
      var response = await http.get(
        url,
        headers: {
          'Authentication': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          recommendedList.removeAt(index); // Remove from the list
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Property deleted successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete property. Status code: ${response.statusCode}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }

  // Show confirmation dialog before deleting
  void _confirmDelete(int propertyId, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Property'),
        content: const Text('Are you sure you want to delete this property?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(), // Cancel
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
              _deleteProperty(propertyId, index); // Proceed with delete
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      height: 340,
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                bool isBookmarked = bookmarkedSet.contains(index);
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return DetailPage(house: recommendedList[index]);
                    }));
                  },
                  child: Container(
                    height: 300,
                    width: 400,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Stack(
                      children: [
                        recommendedList[index].imageUrl.isNotEmpty
                            ? Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(recommendedList[index].imageUrl),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            : const Center(child: Text('No Image Available')),
                             Positioned(top: 10,
                            right: 10,
                            child: CircleIconButton(
                                  iconUrl: isBookmarked
                                      ? 'assets/icons/bookmark.svg'
                                      : 'assets/icons/bookmark22.svg',
                                  color: isBookmarked ? Colors.orange : Colors.grey,
                                  onPressed: () {
                                    _toggleBookmark(index);
                                  },
                                ),
                                ),

                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            color: Colors.white54,
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      recommendedList[index].name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                    ),
                                    Text(
                                      recommendedList[index].location,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                    ),
                                    const SizedBox(height: 5),
                                  ],
                                ),

                                // Show Delete Button if the user is an "Owner"
                                if (_role == 'Owner')
                                  IconButton(
                                    icon: const Icon(Icons.delete, color: Colors.red),
                                    onPressed: () {
                                      _confirmDelete(recommendedList[index].id, index);
                                    },
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (_, index) => const SizedBox(width: 20),
              itemCount: recommendedList.length,
            ),
    );
  }
}
                                      
 