import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medway/const/app_colors.dart';
import 'package:medway/ui/bottom_nav_pages/Medicines.dart';
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

  final _pages = [Home(), Medicines(), Favourite(), Cart(), Profile()];
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        elevation: 5,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        backgroundColor: AppColors.orange_accent,
        unselectedItemColor: AppColors.nav_unselelcted,
        currentIndex: _currentIndex,
        selectedLabelStyle:
        TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home), label:"Home",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_pharmacy), label:"Medicines",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label:"Favourite",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label:"Cart",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), label:"Profile",
          ),
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
