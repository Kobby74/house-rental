import 'package:flutter/material.dart';
import 'package:lodge/model/house.dart';
import 'package:lodge/screen/detail/detail.dart';
import 'package:lodge/widget/circle_icon_button.dart';

class RecommendedHouse extends StatelessWidget {
  final recommendedList = House.generateRecommended();

  RecommendedHouse({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      height: 340,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return DetailPage(house: recommendedList[index],);
              }
));
          },
          child: Container(
            height: 300,
            width: 200,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Stack(children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      recommendedList[index].imageUrl,),
                      fit: BoxFit.cover)),
              ),
              Image.asset(recommendedList[index].imageUrl,
            fit: BoxFit.cover,),
             Positioned(
              right: 15,
              top: 15,
              child: CircleIconButton(
                iconUrl: 'assets/icons/bookmark1.svg', 
                color: Colors.white, onPressed: () {  },)),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    color: Colors.white54,
                    padding:  EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(recommendedList[index].name,
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),),
                            Text(recommendedList[index].address,
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,),
                              ),
                               SizedBox(height: 5,),
                          ],
                        ),
                         CircleIconButton(iconUrl: 'assets/icons/bookmark22.svg', 
                        color: Colors.deepOrange, onPressed: () {  },)
                      ],
                    ),
                  )
                )
            ],)
          ),
        ), 
      separatorBuilder: (_, index) => SizedBox(width: 20), 
      itemCount: recommendedList.length)
    );
  }
}