import 'package:flutter/material.dart';

class WelcomeText extends StatelessWidget{
  
@override
  Widget build(BuildContext context) {
   return Container(
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Hello Kobby!',
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
          fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black26
        ),),
         SizedBox(height: 10),
        Text('Find your sweet Home!',
        style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontSize: 20, fontWeight: FontWeight.bold),)
      ],
    ),
   );
  }
}