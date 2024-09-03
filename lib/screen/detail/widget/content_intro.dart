import 'package:flutter/material.dart';
import 'package:lodge/model/house.dart';

class ContentIntro extends StatelessWidget {
  final House house;
  const ContentIntro({Key? key, required this.house}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Text(house.name,
        style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black) ),
         SizedBox(height: 10,),
        Text(house.location,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 14, color: Colors.black)),
         SizedBox(height: 10,),
        Text(house.description,style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 14, color: Colors.black)),
         SizedBox(height: 10,),
        Text(house.price,style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold)),
         SizedBox(height: 10,),
        house.buildBedroomIcon(),
         SizedBox(height: 10,),
        house.buildKitchenIcon(),
         SizedBox(height: 10,),
        house.buildBathroomIcon(),
         SizedBox(height: 10,),
      ],),
    );
  }
}