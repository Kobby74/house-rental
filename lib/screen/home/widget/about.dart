import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({super.key});


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20,),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('About',
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontSize: 20, fontWeight: FontWeight.bold ),),
          const SizedBox(height: 10,),
          Text('Owner:Mr.SARQUAH SAMUEL \nContact:0505437841',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 16, color: Colors.black26),)
        ],
      ),
    );
  }
}