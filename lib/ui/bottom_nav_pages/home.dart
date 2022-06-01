import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medway/const/app_colors.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _firestoreInstance = FirebaseFirestore.instance;
  List<String> _sliderImages = [];
  var _dotPosition = 0;
  List _products = [];

  TextEditingController _searchController = TextEditingController();


//carousel image function
  carouselImages() async {
    QuerySnapshot qn =
        await _firestoreInstance.collection("carousel-slider").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _sliderImages.add(
          qn.docs[i]["img-path"],
        );
        print(qn.docs[i]["img-path"]);
      }
    });

    return qn.docs;
  }

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
    carouselImages();
    products();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppColors.orange_accent,
        elevation: 0,
        title: Text(
          "Med-Way",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 60.h,
                          child: TextFormField(
                            controller: _searchController,
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10),),
                                    borderSide: BorderSide(
                                      color: AppColors.main_color,
                                    )),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10),),
                                    borderSide: BorderSide(
                                      color: AppColors.orange_accent,
                                    )),
                                hintText: "Search medicines here...",
                                hintStyle: TextStyle(fontSize: 13.sp)),
                          ),
                        ),
                      ),
                      GestureDetector(
                        child: Container(
                          color: AppColors.orange_accent,
                          height: 60.h,
                          width: 90.h,
                          child: Center(
                            child: Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                //Slider
                AspectRatio(
                  aspectRatio: 3,
                  child: CarouselSlider(
                      items: _sliderImages
                          .map((item) => Padding(
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
                        autoPlay: true,
                          autoPlayInterval: Duration(seconds: 3),
                          autoPlayAnimationDuration: Duration(milliseconds: 800),
                          enlargeCenterPage: true,
                          viewportFraction: 0.9,
                          enlargeStrategy: CenterPageEnlargeStrategy.height,
                          onPageChanged: (val, carouselPageChangedReason) {
                            setState(() {
                              _dotPosition = val;
                            });
                          })),
                ),
                SizedBox(
                  height: 10.h,
                ),
                //Dots Indicator
                DotsIndicator(
                  dotsCount:
                      _sliderImages.length == 0 ? 1 : _sliderImages.length,
                  position: _dotPosition.toDouble(),
                  decorator: DotsDecorator(
                    activeColor: AppColors.orange_accent,
                    color: AppColors.orange_accent.withOpacity(0.5),
                    spacing: EdgeInsets.all(2),
                    activeSize: Size(7, 7),
                    size: Size(6, 6),
                  ),
                ),
                SizedBox(
                  height: 40.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Most Searched Medicines", style: TextStyle(
                        color: Colors.deepOrange,
                        fontSize: 30,
                        fontWeight: FontWeight.normal,
                        shadows:[Shadow(color:Colors.black54, offset:Offset(1,2), blurRadius: 4 ) ]
                    )),
                  ],
                ),
                SizedBox(
                  height: 25.h,
                ),
                Container(
                  height: 175,
                  child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _products.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
                    itemBuilder: (_,index){
                      return Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5, bottom: 3),
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
                ),),
                SizedBox(
                  height: 25.h,
                ),
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
                          return Card(
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
                          );
                        }
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}