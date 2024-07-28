import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  CustomBottomNavigationBar({super.key});

  @override
  _CustomBottomNavigationBarState createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  final bottomBarItem = [
    'home-svgrepo-com',
    'search-4-svgrepo-com',
    'notification-bell-new-svgrepo-com',
    'chat-dots-svgrepo-com2',
    'bookmark1'
  ];
  
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    void _onItemTapped(int index) {
  setState(() {
    _selectedIndex = index;
  });

  switch (index) {
    case 0:
      Navigator.pushNamed(context, '/home');
      break;
    case 1:
      Navigator.pushNamed(context, '/search');
      break;
    case 2:
      Navigator.pushNamed(context, '/notifications');
      break;
    case 3:
      Navigator.pushNamed(context, '/chat');
      break;
    case 4:
      Navigator.pushNamed(context, '/bookmarks');
      break;
    default:
      Navigator.pushNamed(context, '/home');
  }
}

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 25),
      padding: EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: bottomBarItem.asMap().entries.map((entry) {
          int idx = entry.key;
          String assetName = entry.value;
          return GestureDetector(
            onTap: () => _onItemTapped(idx),
            child: SvgPicture.asset(
              'assets/icons/$assetName.svg',
              color: _selectedIndex == idx ? Colors.blue : Colors.grey,
            ),
          );
        }).toList(),
      ),
    );
  }
}
