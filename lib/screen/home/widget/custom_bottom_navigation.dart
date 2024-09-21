import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lodge/screen/home/home.dart';
import 'package:lodge/screen/home/widget/bookmarks.dart';
import 'package:lodge/screen/home/widget/chat.dart';
import 'package:lodge/screen/home/widget/notifications.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key});

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


    switch (index) {
      case 0:
        Navigator.push(context, MaterialPageRoute(builder: 
        (context) => const HomePage(role: 'role', username: 'username',)));
        break;
      case 1:
        Navigator.pushNamed(context, '/search');
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: 
        (context) => const NotificationsScreen()));
        break;
      case 3:
        Navigator.push(context, MaterialPageRoute(
          builder: (context)=> const ChatScreen(chatId: '123')));
        break;
      case 4:
        Navigator.push(context, MaterialPageRoute(builder: 
        (context) => BookmarksScreen()));
        break;
      default:
        Navigator.pushNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 25),
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 7,
            offset: const Offset(0, 3),
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