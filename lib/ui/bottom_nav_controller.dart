import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medway/const/app_colors.dart';
import 'package:medway/ui/bottom_nav_pages/cart.dart';
import 'package:medway/ui/bottom_nav_pages/favourite.dart';
import 'package:medway/ui/bottom_nav_pages/home.dart';
import 'package:medway/ui/bottom_nav_pages/profile.dart';

class BottomNavController extends StatefulWidget {
  const BottomNavController({Key? key}) : super(key: key);

  @override
  State<BottomNavController> createState() => _BottomNavControllerState();
}

class _BottomNavControllerState extends State<BottomNavController> {

  final _pages = [Home(), Favourite(), Cart(), Profile()];
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.orange_accent,
        unselectedItemColor: AppColors.accent_color,
        selectedLabelStyle: TextStyle(color: AppColors.text_color, fontWeight: FontWeight.bold,),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label:"Home", backgroundColor: Colors.grey),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label:"Favourite", backgroundColor: Colors.grey),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label:"Cart", backgroundColor: Colors.grey),
          BottomNavigationBarItem(icon: Icon(Icons.person), label:"Profile", backgroundColor: Colors.grey),
        ],
        onTap: (index){
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      body: _pages[_currentIndex],
    );
  }
}
