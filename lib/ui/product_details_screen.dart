import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../const/app_colors.dart';

class ProductDetails extends StatefulWidget {


  var _products;
  ProductDetails(this._products);


  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {

  var _dotsPosition = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            //image slider
            SizedBox(height: 10.h,),
            AspectRatio(
              aspectRatio: 2,
              child: CarouselSlider(
                  items: widget._products['product-image'].map<Widget>((item) => Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          image: DecorationImage(
                              image: NetworkImage(item),
                              fit: BoxFit.fill)),
                    ),
                  ))
                      .toList(),
                  options: CarouselOptions(
                      autoPlay: false,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      enlargeCenterPage: true,
                      viewportFraction: 1,
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                      onPageChanged: (val, carouselPageChangedReason) {
                        setState(() {
                          _dotsPosition = val;
                        });
                      })),
            ),
            SizedBox(height: 10.h,),
            //dots indicator
            DotsIndicator(
              dotsCount:
              widget._products['product-image'].length == 0 ? 1 : widget._products['product-image'].length,
              position: _dotsPosition.toDouble(),
              decorator: DotsDecorator(
                activeColor: AppColors.orange_accent,
                color: AppColors.orange_accent.withOpacity(0.5),
                spacing: EdgeInsets.all(2),
                activeSize: Size(7, 7),
                size: Size(6, 6),
              ),
            ),
            //Product Name & Price
            Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget._products['product-name'], style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold,color: AppColors.orange_accent)),
                  Text("৳ ${widget._products["product-price"].toString()}", style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold,color: AppColors.orange_accent),),
                ],
              ),
            ),
            SizedBox(height: 15.h,),
            //Descriptions
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Descriptions",style: TextStyle(fontSize: 18.sp, color: AppColors.text_color, fontWeight: FontWeight.bold),)
                ],
              ),
            ),
            SizedBox(height: 10.h,),
            Container(
              height: 270,
                child: Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: SingleChildScrollView(
                child: Text(widget._products['product-description'], style: TextStyle(
                  fontSize: 16.sp,
                  color: AppColors.text_color,
                  height: 1.5,
                ),),
              ),
            ))
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child:
                FlatButton(onPressed: (){}, child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("Add to Cart", style: TextStyle(fontSize: 17.sp),),
                ), color: AppColors.orange_accent, textColor: Colors.white,))
          ],
        ),
      ),
    );
  }
}
