import 'package:flutter/material.dart';
import 'package:medway/const/app_colors.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.orange_accent,
        elevation: 0,
        title: Text("Cart", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
    );
  }
}
