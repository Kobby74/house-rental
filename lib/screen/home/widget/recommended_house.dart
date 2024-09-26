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
  String? loggedInUserId; // Store logged-in user ID
  final Set<int> bookmarkedSet = {}; // Track the bookmarked houses

  @override
  void initState() {
    super.initState();
    fetchUserId(); // Fetch logged-in user ID first
    fetchRecommendedHouses();
  }

  Future<void> fetchUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      loggedInUserId = prefs.getString('user_id'); // Assuming 'user_id' was saved after login
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

  // Function to delete a property
  Future<void> _deleteProperty(String propertyId, int index) async {
    try {
      var url = Uri.parse('https://rentapp-api.drevap.com/api/property/delete');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('access_token'); // Fetch bearer token
      var response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          recommendedList.removeAt(index); // Remove the property from the list on successful delete
        });
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Property deleted successfully')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to delete property')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('An error occurred: $e')));
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
                bool isBookmarked = bookmarkedSet.contains(index); // Check if bookmarked
                var house = recommendedList[index];
                bool isOwner = house.ownerId == loggedInUserId; // Check if logged-in user is the owner

                return GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return DetailPage(house: recommendedList[index]);
                    }));
                  },
                  child: Container(
                    height: 300,
                    width: 200,
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
                                if (isOwner) // Show delete button only for the owner
                                  IconButton(
                                    icon: const Icon(Icons.delete, color: Colors.red),
                                    onPressed: () {
                                      _deleteProperty(house.id.toString(), index);
                                    },
                                  ),
                                CircleIconButton(
                                  iconUrl: isBookmarked
                                      ? 'assets/icons/bookmark.svg'  // Icon for bookmarked state
                                      : 'assets/icons/bookmark22.svg', // Default icon
                                  color: isBookmarked ? Colors.orange : Colors.grey, // Change color when bookmarked
                                  onPressed: () {
                                    _toggleBookmark(index); // Toggle bookmark state
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
