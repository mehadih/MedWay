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
  List<String> _sliderImages = [];
  var _dotPosition = 0;
  var _firestoreInstance = FirebaseFirestore.instance;

  TextEditingController _searchController = TextEditingController();

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

  @override
  void initState() {
    carouselImages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: SafeArea(
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
                                      BorderRadius.all(Radius.circular(0)),
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
            ],
          ),
        ),
      ),
    );
  }
}
