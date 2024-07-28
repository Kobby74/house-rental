import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class House {
  String name;
  String address;
  String description;
  String price;
  String imageUrl;
  String bedroomSvg;
  String kitchenSvg;
  String bathroomSvg;

  House(
    this.name,
    this.address,
    this.imageUrl,
    this.description,
    this.price,
    this.bedroomSvg,
    this.kitchenSvg,
    this.bathroomSvg,
  );

  static List<House> generateRecommended() {
    return [
      House(
        'Chestnut House',
        'Community 5, Tema',
        'assets/images/OIP2.jpg',
        '📍6000 sqft\n🅿Parking loft',
        '💰GH₵6500/month',
        'assets/icons/bedroom.svg',
        'assets/icons/kitchen-room-svgrepo-com.svg',
        'assets/icons/bathroom.svg',
      ),
      House(
        'Willow Way',
        'TseAddo',
        'assets/images/R.jpg',
        '4000 sqft',
        'GH₵4800/month',
        'assets/icons/bedroom.svg',
        'assets/icons/kitchen-room-svgrepo-com.svg',
        'assets/icons/bathroom.svg',
      ),
      House(
        'The Oak Plus',
        'Tesano',
        'assets/images/The Oak Plus.jpg',
        '4400 sqft',
        'GH₵5200/month',
        'assets/icons/bedroom.svg',
        'assets/icons/kitchen-room-svgrepo-com.svg',
        'assets/icons/bathroom.svg',
      ),
      House(
        'Mizu',
        'TseAddo',
        'assets/images/R2.jpg',
        '4700 sqft',
        'GH₵5600/month',
        'assets/icons/bedroom.svg',
        'assets/icons/kitchen-room-svgrepo-com.svg',
        'assets/icons/bathroom.svg',
      ),
    ];
  }

  static List<House> generateBestOffer() {
    return [
      House(
        'Milky Way',
        'East Legon-hills',
        'assets/images/MR7435.jpg',
        '6000 sqft',
        'GH₵4500/month',
        'assets/icons/bedroom.svg',
        'assets/icons/kitchen-room-svgrepo-com.svg',
        'assets/icons/bathroom.svg',
      ),
      House(
        'Cresent Home',
        'Devtracco-Tema',
        'assets/images/b114e8fae7fdee6_t_w_800_h_600.jpeg',
        '6000 sqft',
        'GH₵4500/month',
        'assets/icons/bedroom.svg',
        'assets/icons/kitchen-room-svgrepo-com.svg',
        'assets/icons/bathroom.svg',
      ),
      House(
        'White Galaxy',
        'Tesano-Accra',
        'assets/images/4-bed-2a.jpg',
        '6000 sqft',
        'GH₵4500/month',
        'assets/icons/bedroom.svg',
        'assets/icons/kitchen-room-svgrepo-com.svg',
        'assets/icons/bathroom.svg',
      ),
      House(
        'Hart lane',
        'Sakumono-Comm.14',
        'assets/images/OIP.jpg',
        '6000 sqft',
        'GH₵4500/month',
        'assets/icons/bedroom.svg',
        'assets/icons/kitchen-room-svgrepo-com.svg',
        'assets/icons/bathroom.svg',
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
        SizedBox(width: 5),
        Text('5 Bedroom'),
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
        SizedBox(width: 5),
        Text('2 kitchens'),
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
        SizedBox(width: 5),
        Text('3 bathrooms \n3washrooms'),
      ],
    );
  }
}
