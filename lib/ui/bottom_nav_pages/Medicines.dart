import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../const/app_colors.dart';
import '../product_details_screen.dart';

class Medicines extends StatefulWidget {
  const Medicines({Key? key}) : super(key: key);

  @override
  State<Medicines> createState() => _MedicinesState();
}

class _MedicinesState extends State<Medicines> {

  var _firestoreInstance = FirebaseFirestore.instance;
  List _products = [];

  //Products
  products() async {
    QuerySnapshot az =
    await _firestoreInstance.collection("products").get();
    setState(() {
      for (int i = 0; i < az.docs.length; i++) {
        _products.add(
            {
              "product-name": az.docs[i]["product-name"],
              "product-description": az.docs[i]["product-description"],
              "product-price": az.docs[i]["product-price"],
              "product-image": az.docs[i]["product-img"],
            }
        );
      }
    });

    return az.docs;
  }


  @override
  void initState() {
    products();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.orange_accent,
        elevation: 0,
        title: Text(
          "Medicines",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: _products.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 16),
                        itemBuilder: (_,index){
                          return GestureDetector(
                            onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> ProductDetails(_products[index]))),
                            child: Card(
                              shape: UnderlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.deepOrange, width: 2.0 )),
                              elevation: 7,
                              child:
                              Column(
                                children: [
                                  SizedBox(height: 5.h,),
                                  Expanded(
                                      child: AspectRatio(
                                          aspectRatio: 1.75,
                                          child: Image.network(_products[index]["product-image"][0], fit: BoxFit.fill,))
                                  ),
                                  SizedBox(height: 15.h,),
                                  Text("${_products[index]["product-name"]}",style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold,color: AppColors.text_color),),
                                  SizedBox(height: 10.h,),
                                  Text("৳ ${_products[index]["product-price"].toString()}", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold,color: AppColors.orange_accent),),
                                  SizedBox(height: 5.h,),
                                ],
                              ),
                            ),
                          );
                        }
                    ),
                  ),
                ),
              ],
            ),),
      ),
    );
  }
}
