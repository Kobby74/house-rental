import 'package:flutter/material.dart';
import 'package:lodge/model/house.dart';
import 'package:lodge/screen/detail/detail.dart';
import 'package:lodge/widget/circle_icon_button.dart';

class BestOffer extends StatefulWidget {
  BestOffer({Key? key}) : super(key: key);

  @override
  _BestOfferState createState() => _BestOfferState();
}

class _BestOfferState extends State<BestOffer> {
  final listOfOffer = House.generateBestOffer();
  final Set<int> favoriteSet = {};

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
          ...listOfOffer.map((el) {
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
                          width: 150,
                          height: 80,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(el.imageUrl),
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
                              el.address,
                              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontSize: 12,
                                    color: Colors.black,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Positioned(
                      right: 0,
                      child: CircleIconButton(
                        iconUrl: 'assets/icons/heart1-svgrepo-com.svg',
                        color: isFavorite ? Colors.red : Color.fromARGB(255, 255, 255, 255),
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
