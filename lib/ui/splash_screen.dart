import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medway/const/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medway/ui/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), ()=>Navigator.push(context, CupertinoPageRoute(builder: (_) => LoginScreen())));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(image: AssetImage("assets/logo tag.png")),
            SizedBox(height: 20,),
            CircularProgressIndicator(
              color: AppColors.main_color,
              strokeWidth: 3.5,
            )
          ],
        ),
      )),
    );
  }
}
