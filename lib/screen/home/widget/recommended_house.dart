import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lodge/model/house.dart';
import 'package:lodge/screen/detail/detail.dart';
import 'package:lodge/widget/circle_icon_button.dart';
import 'package:http/http.dart' as http;

class RecommendedHouse extends StatefulWidget {
  const RecommendedHouse({super.key});

  @override
  _RecommendedHouseState createState() => _RecommendedHouseState();
}

class _RecommendedHouseState extends State<RecommendedHouse> {
  List<House> recommendedList = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchRecommendedHouses();
  }

Future<void> fetchRecommendedHouses() async {
  try {
    var url = Uri.parse('https://rentapp-api.drevap.com/api/property/');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      print('Response Body: ${response.body}');
      var data = jsonDecode(response.body);

      // Check if 'data' is a list or a map
      if (data is List) {
        // Directly map the list
        setState(() {
          recommendedList = data.map((json) => House.fromJson(json)).toList();
          isLoading = false;
        });
      } else if (data is Map) {
        // Check if the map contains a list of properties
        if (data['properties'] != null && data['properties'] is List) {
          setState(() {
            recommendedList = (data['properties'] as List)
                .map((json) => House.fromJson(json))
                .toList();
            isLoading = false;
          });
        } else {
          // Handle case where 'properties' is not found or is not a list
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Unexpected data format.')),
          );
          setState(() {
            isLoading = false;
          });
        }
      } else {
        // Handle unexpected data structure
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Unexpected data format.')),
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



  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      height: 340,
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
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
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(recommendedList[index].imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 15,
                        top: 15,
                        child: CircleIconButton(
                          iconUrl: 'assets/icons/bookmark1.svg',
                          color: Colors.white,
                          onPressed: () {},
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
                              CircleIconButton(
                                iconUrl: 'assets/icons/bookmark22.svg',
                                color: Colors.deepOrange,
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              separatorBuilder: (_, index) => const SizedBox(width: 20),
              itemCount: recommendedList.length,
            ),
    );
  }
}
