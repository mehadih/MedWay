import 'package:flutter/material.dart';
import 'package:medway/const/app_colors.dart';

class Favourite extends StatefulWidget {
  const Favourite({Key? key}) : super(key: key);

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.orange_accent,
        elevation: 0,
        title: Text("Favourites", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
    );
  }
}
