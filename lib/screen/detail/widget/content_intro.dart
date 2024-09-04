import 'package:flutter/material.dart';
import 'package:lodge/model/house.dart';

class ContentIntro extends StatelessWidget {
  final House house;
  const ContentIntro({super.key, required this.house});


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Text(house.name,
        style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black) ),
         const SizedBox(height: 10,),
        Text(house.location,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 14, color: Colors.black)),
         const SizedBox(height: 10,),
        Text(house.description,style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 14, color: Colors.black)),
         const SizedBox(height: 10,),
        Text(house.price,style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold)),
         const SizedBox(height: 10,),
        house.buildBedroomIcon(),
         const SizedBox(height: 10,),
        house.buildKitchenIcon(),
         const SizedBox(height: 10,),
        house.buildBathroomIcon(),
         const SizedBox(height: 10,),
      ],),
    );
  }
}