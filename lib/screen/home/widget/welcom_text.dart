import 'package:flutter/material.dart';

class WelcomeText extends StatelessWidget{
  final String username;
  const WelcomeText({super.key, required this.username});

  

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hello!',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black26,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Find your sweet Home!',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}