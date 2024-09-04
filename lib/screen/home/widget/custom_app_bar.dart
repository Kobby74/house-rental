import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lodge/login_page.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PopupMenuButton<String>(
              icon: SvgPicture.asset('assets/icons/menu-svgrepo-com.svg'),
              onSelected: (value) {
                if (value == 'logout') {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                } else {
                
                  print(value);
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'recommended',
                  child: Text('Recommended'),
                ),
                const PopupMenuItem<String>(
                  value: 'near_you',
                  child: Text('Near You'),
                ),
                const PopupMenuItem<String>(
                  value: 'best_offer',
                  child: Text('Best Offer'),
                ),
                const PopupMenuItem<String>(
                  value: 'agency_recommended',
                  child: Text('Agency Recommended'),
                ),
                const PopupMenuDivider(),
                const PopupMenuItem<String>(
                  value: 'logout',
                  child: Text('Logout'),
                ),
              ],
            ),
            Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const CircleAvatar(
              backgroundImage: AssetImage('assets/images/OIP.jpg'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
