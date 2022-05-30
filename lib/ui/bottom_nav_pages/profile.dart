import 'package:flutter/material.dart';
import 'package:medway/const/app_colors.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.orange_accent,
        elevation: 0,
        title: Text("My Profile", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
    );
  }
}
