import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lodge/login_page.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  CustomAppBar(this.title);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PopupMenuButton<String>(
              icon: SvgPicture.asset('assets/icons/menu-svgrepo-com.svg'),
              onSelected: (value) {
                if (value == 'logout') {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                } else {
                
                  print(value);
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: 'recommended',
                  child: Text('Recommended'),
                ),
                PopupMenuItem<String>(
                  value: 'near_you',
                  child: Text('Near You'),
                ),
                PopupMenuItem<String>(
                  value: 'best_offer',
                  child: Text('Best Offer'),
                ),
                PopupMenuItem<String>(
                  value: 'agency_recommended',
                  child: Text('Agency Recommended'),
                ),
                PopupMenuDivider(),
                PopupMenuItem<String>(
                  value: 'logout',
                  child: Text('Logout'),
                ),
              ],
            ),
            Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/OIP.jpg'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50);
}
