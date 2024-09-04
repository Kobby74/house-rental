import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class House {
  String name;
  String location;
  String description;
  String price;
  String imageUrl;
  String region;
  String town;
  String country;
  String gpsAddress;
  String bedroomSvg;
  String kitchenSvg;
  String bathroomSvg;

  House({
    required this.name,
    required this.location,
    required this.imageUrl,
    required this.description,
    required this.price,
    required this.region,
    required this.town,
    required this.country,
    required this.gpsAddress,
    required this.bedroomSvg,
    required this.kitchenSvg,
    required this.bathroomSvg,
  });


factory House.fromJson(Map<String, dynamic> json) {
  return House(
    name: json['name'] ?? 'Unknown House',
    location: json['location'] ?? 'Unknown Location',
    imageUrl: json['image_urls'] != null && json['image_urls'].isNotEmpty
        ? json['image_urls'][0]
        : 'assets/images/placeholder.jpg',
    description: json['description'] ?? 'No description available',
    price: json['price'] ?? 'No price available',
    bedroomSvg: 'assets/icons/bedroom.svg',
    kitchenSvg: 'assets/icons/kitchen-room-svgrepo-com.svg',
    bathroomSvg: 'assets/icons/bathroom.svg',
    region: json['region'] ?? 'Unknown Region',
    town: json['town'] ?? 'Unknown Town',
    country: json['country'] ?? 'Unknown Country',
    gpsAddress: json['gpsAddress'] ?? 'Unknown GPS Address',
  );
}



  static List<House> generateRecommended() {
    return [
      House(
        name: 'Chestnut House',
        location: 'Community 5, Tema',
        imageUrl: 'assets/images/OIP2.jpg',
        description: '📍6000 sqft\n🅿Parking loft',
        price: '💰GH₵6500/month',
        bedroomSvg: 'assets/icons/bedroom.svg',
        kitchenSvg: 'assets/icons/kitchen-room-svgrepo-com.svg',
        bathroomSvg: 'assets/icons/bathroom.svg',
        region: 'Greater Accra',
        town: 'Tema',
        country: 'Ghana',
        gpsAddress: '5.7323, -0.0333',
      ),
      House(
        name: 'Willow Way',
        location: 'TseAddo',
        imageUrl: 'assets/images/R.jpg',
        description: '4000 sqft',
        price: 'GH₵4800/month',
        bedroomSvg: 'assets/icons/bedroom.svg',
        kitchenSvg: 'assets/icons/kitchen-room-svgrepo-com.svg',
        bathroomSvg: 'assets/icons/bathroom.svg',
        region: 'Greater Accra',
        town: 'TseAddo',
        country: 'Ghana',
        gpsAddress: '5.7323, -0.0333',
      ),
      House(
        name: 'The Oak Plus',
        location: 'Tesano',
        imageUrl: 'assets/images/The Oak Plus.jpg',
        description: '4400 sqft',
        price: 'GH₵5200/month',
        bedroomSvg: 'assets/icons/bedroom.svg',
        kitchenSvg: 'assets/icons/kitchen-room-svgrepo-com.svg',
        bathroomSvg: 'assets/icons/bathroom.svg',
        region: 'Greater Accra',
        town: 'Tesano',
        country: 'Ghana',
        gpsAddress: '5.7323, -0.0333',
      ),
      House(
        name: 'Mizu',
        location: 'TseAddo',
        imageUrl: 'assets/images/R2.jpg',
        description: '4700 sqft',
        price: 'GH₵5600/month',
        bedroomSvg: 'assets/icons/bedroom.svg',
        kitchenSvg: 'assets/icons/kitchen-room-svgrepo-com.svg',
        bathroomSvg: 'assets/icons/bathroom.svg',
        region: 'Greater Accra',
        town: 'TseAddo',
        country: 'Ghana',
        gpsAddress: '5.7323, -0.0333',
      ),
    ];
  }

  
  static List<House> generateBestOffer() {
    return [
      House(
        name: 'Milky Way',
        location: 'East Legon-hills',
        imageUrl: 'assets/images/MR7435.jpg',
        description: '6000 sqft',
        price: 'GH₵4500/month',
        bedroomSvg: 'assets/icons/bedroom.svg',
        kitchenSvg: 'assets/icons/kitchen-room-svgrepo-com.svg',
        bathroomSvg: 'assets/icons/bathroom.svg',
        region: 'Greater Accra',
        town: 'East Legon-hills',
        country: 'Ghana',
        gpsAddress: '5.7323, -0.0333',
      ),
      House(
        name: 'Cresent Home',
        location: 'Devtracco-Tema',
        imageUrl: 'assets/images/b114e8fae7fdee6_t_w_800_h_600.jpeg',
        description: '6000 sqft',
        price: 'GH₵4500/month',
        bedroomSvg: 'assets/icons/bedroom.svg',
        kitchenSvg: 'assets/icons/kitchen-room-svgrepo-com.svg',
        bathroomSvg: 'assets/icons/bathroom.svg',
        region: 'Greater Accra',
        town: 'Devtracco-Tema',
        country: 'Ghana',
        gpsAddress: '5.7323, -0.0333',
      ),
      House(
        name: 'White Galaxy',
        location: 'Tesano-Accra',
        imageUrl: 'assets/images/4-bed-2a.jpg',
        description: '6000 sqft',
        price: 'GH₵4500/month',
        bedroomSvg: 'assets/icons/bedroom.svg',
        kitchenSvg: 'assets/icons/kitchen-room-svgrepo-com.svg',
        bathroomSvg: 'assets/icons/bathroom.svg',
        region: 'Greater Accra',
        town: 'Tesano-Accra',
        country: 'Ghana',
        gpsAddress: '5.7323, -0.0333',
      ),
      House(
        name: 'Hart lane',
        location: 'Sakumono-Comm.14',
        imageUrl: 'assets/images/OIP.jpg',
        description: '6000 sqft',
        price: 'GH₵4500/month',
        bedroomSvg: 'assets/icons/bedroom.svg',
        kitchenSvg: 'assets/icons/kitchen-room-svgrepo-com.svg',
        bathroomSvg: 'assets/icons/bathroom.svg',
        region: 'Greater Accra',
        town: 'Sakumono-Comm.14',
        country: 'Ghana',
        gpsAddress: '5.7323, -0.0333',
      ),
    ];
  }

  
  Widget buildBedroomIcon() {
    return Row(
      children: [
        SvgPicture.asset(
          bedroomSvg,
          width: 30,
          height: 30,
        ),
        const SizedBox(width: 5),
        const Text('5 Bedroom'),
      ],
    );
  }

  Widget buildKitchenIcon() {
    return Row(
      children: [
        SvgPicture.asset(
          kitchenSvg,
          width: 30,
          height: 30,
        ),
        const SizedBox(width: 5),
        const Text('2 kitchens'),
      ],
    );
  }

  Widget buildBathroomIcon() {
    return Row(
      children: [
        SvgPicture.asset(
          bathroomSvg,
          width: 30,
          height: 30,
        ),
        const SizedBox(width: 5),
        const Text('3 bathrooms \n3 washrooms'),
      ],
    );
  }
}
