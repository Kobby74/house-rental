import 'dart:convert'; // For jsonDecode  
import 'dart:math';
import 'package:flutter/material.dart';  
import 'package:http/http.dart' as http; // For HTTP requests  
import 'package:lodge/model/house.dart';  
import 'package:lodge/screen/detail/detail.dart';  
import 'package:lodge/widget/circle_icon_button.dart';  

class BestOffer extends StatefulWidget {  
  const BestOffer({super.key});  

  @override  
  _BestOfferState createState() => _BestOfferState();  
}  

class _BestOfferState extends State<BestOffer> {  
  List<House> listOfOffer = [];  
  final Set<int> favoriteSet = {};  
  bool isLoading = true; // Loading state indicator  

  @override  
  void initState() {  
    super.initState();  
    _fetchBestOffers();  
  }  

  Future<void> _fetchBestOffers() async {  
    try {  
      var url = Uri.parse('https://rentapp-api.drevap.com/api/property/');  
      var response = await http.get(url);
      if (response.statusCode == 200) {  
        var data = jsonDecode(response.body); 

        if (data is List){
          setState(() {
            listOfOffer = data.map((e) => House.fromJson(e)).toList();
            isLoading = false;
          });
        }  else if (data is Map && data['data'] != null && data['data'] is List){
          setState(() {
            listOfOffer = (data['data'] as List).map((e) => House.fromJson(e)).toList();
            isLoading = false;
          });
        }

        // Sort the offers by price  
        listOfOffer.sort((a, b) => a.price.compareTo(b.price));  

        setState(() {  
          isLoading = false; // Stop loading after fetching data  
        });  
      } else {  
        // Handle error response  
        print('Failed to load properties: ${response.statusCode}');  
        setState(() {  
          isLoading = false; // Stop loading on error  
        });  
      }  
    } catch (e) {  
      // Handle any exceptions  
      print('Exception occurred: $e');  
      setState(() {  
        isLoading = false; // Stop loading on exception  
      });  
    }  
  }  

  void _toggleFavorite(int index) {  
    setState(() {  
      if (favoriteSet.contains(index)) {  
        favoriteSet.remove(index);  
      } else {  
        favoriteSet.add(index);  
      }  
    });  
  }  

  @override  
  Widget build(BuildContext context) {  
    return Container(  
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),  
      child: Column(  
        children: [  
          Row(  
            mainAxisAlignment: MainAxisAlignment.spaceBetween,  
            children: [  
              Text(  
                'Best Offer',  
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(  
                      fontSize: 16,  
                      fontWeight: FontWeight.bold,  
                      color: Colors.black,  
                    ),  
              ),  
              Text(  
                'See All',  
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(  
                      fontSize: 13,  
                      color: Colors.black54,  
                    ),  
              ),  
            ],  
          ),  
          const SizedBox(height: 10),  
          if (isLoading)   
            Center(child: CircularProgressIndicator())  
          else if (listOfOffer.isNotEmpty) ...listOfOffer.map((el) {  
            int index = listOfOffer.indexOf(el);  
            bool isFavorite = favoriteSet.contains(index);  
            return GestureDetector(  
              onTap: () {  
                Navigator.of(context).push(MaterialPageRoute(  
                  builder: (context) => DetailPage(house: el),  
                ));  
              },  
              child: Container(  
                margin: const EdgeInsets.only(bottom: 10),  
                padding: const EdgeInsets.all(10),  
                decoration: BoxDecoration(  
                  color: Colors.white,  
                  borderRadius: BorderRadius.circular(8),  
                ),  
                child: Stack(  
                  children: [  
                    Row(  
                      children: [  
                        Container(  
                          width: 100,  
                          height: 80,  
                          decoration: BoxDecoration(  
                            image: DecorationImage(  
                              image: NetworkImage(el.imageUrl), // Use NetworkImage for API URLs  
                              fit: BoxFit.cover,  
                            ),  
                            borderRadius: BorderRadius.circular(8),  
                          ),  
                        ),  
                        const SizedBox(width: 10),  
                        Column(  
                          crossAxisAlignment: CrossAxisAlignment.start,  
                          children: [  
                            Text(  
                              el.name,  
                              style: Theme.of(context).textTheme.headlineLarge!.copyWith(  
                                    fontSize: 16,  
                                    fontWeight: FontWeight.bold,  
                                  ),  
                                  ),  
                                  Text(  
                                    el.location,  
                                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(  
                                      fontSize: 12,  
                                      color: Colors.black,  
                                    ),  
                                  ),  
                                  Text(  
                                    '\$${el.price}', // Example for price display  
                                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(  
                                      fontSize: 12,  
                                      color: Colors.green,  
                                    ),  
                                  ),  
                                ],  
                              ),  
                            ],  
                          ),  
                          Positioned(  
                            right: 0,  
                            child: CircleIconButton(  
                              iconUrl: isFavorite  
                                  ? 'assets/icons/hearts123.svg'  
                                  : 'assets/icons/heart1-svgrepo-com.svg',  
                              color: isFavorite ? Colors.red : Colors.grey,  
                              onPressed: () {  
                                _toggleFavorite(index);  
                              },  
                            ),  
                          ),  
                        ],  
                      ),  
                    ),  
                  );  
                }).toList(),  
              ],  
            ),  
    );  
  }  
}