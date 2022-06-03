import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../const/app_colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var input_text= "";


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
        // automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextFormField(
                textAlign: TextAlign.center,
                decoration:InputDecoration(
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10),),
                        borderSide: BorderSide(
                          color: AppColors.main_color,
                        )),
                    enabledBorder:
                    OutlineInputBorder(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10), topRight:Radius.circular(10),bottomRight: Radius.circular(10) ),
                        borderSide: BorderSide(color: AppColors.orange_accent,)
                    ),
                    hintText: "Search medicines here...",
                    hintStyle: TextStyle(fontSize: 13.sp)),
                onChanged: (val){
                  setState(() {
                    input_text = val;
                    print(input_text);
                  });
                },
              ),
              SizedBox(height: 20.h,),
              Expanded(
                child: Container(
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance.collection("products").where("product-name", isGreaterThanOrEqualTo: input_text).snapshots(),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text("Something went wrong"),
                          );
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: Text("Loading"),
                          );
                        }

                        return ListView(
                          children: snapshot.data!.docs.map((DocumentSnapshot document) {
                            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                            return Card(
                              shape: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepOrange, width: 2.0 )),
                              elevation: 5,
                              margin: EdgeInsets.all(10),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                                child: ListTile(
                                  trailing: Text(data['product-name']),
                                  leading: Image.network(data['product-img'][0], fit: BoxFit.fill,),
                                ),
                              ),
                            );
                          }).toList(),

                        );
                      }
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
