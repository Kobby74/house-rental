import 'package:flutter/material.dart';

class Categories extends StatefulWidget {

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  final categoriesList = [
    'Top Recommended',
    'Near You',
    'Agency Recommended',
    'Most Popular'
  ];
  int currentSelect = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            setState(() {
              currentSelect = index;
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: currentSelect == index ? Theme.of(context).primaryColor : Colors.transparent,
              borderRadius: BorderRadius.circular(18), 
            ),
            alignment: Alignment.center,
            child: Text(
              categoriesList[index],
              style: TextStyle(
                color: currentSelect == index ? Colors.black45 : Theme.of(context).textTheme.bodyLarge!.color,
                fontSize: currentSelect == index ? 16 : 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        separatorBuilder: (_, index) => SizedBox(width: 12),
        itemCount: categoriesList.length,
      ),
    );
  }
}
