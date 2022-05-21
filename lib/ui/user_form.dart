import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:medway/const/app_colors.dart';
import 'package:medway/ui/bottom_nav_controller.dart';
import 'package:medway/widgets/custom_button.dart';

import '../widgets/myTextField.dart';

class UserForm extends StatefulWidget {
  const UserForm({Key? key}) : super(key: key);

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  List<String> gender = ["Male", "Female", "Others"];



  Future<void> _selectDateFromPicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(DateTime.now().year - 20),
      firstDate: DateTime(DateTime.now().year - 30),
      lastDate: DateTime(DateTime.now().year),
    );
    if (picked != null)
      setState(() {
        _dobController.text = "${picked.day}/ ${picked.month}/ ${picked.year}";
      });
  }

sendDatatoFirebase()async{

  final FirebaseAuth _authentication = FirebaseAuth.instance;
  var  currentUser = _authentication.currentUser;

  CollectionReference _collectionRef = FirebaseFirestore.instance.collection("Users Information");
  return _collectionRef.doc(currentUser!.email).set({
    "name":_nameController.text,
    "phone":_phoneController.text,
    "dob":_dobController.text,
    "gender":_genderController.text,
    "age":_ageController.text,
  }).then((value) => Navigator.push(context, MaterialPageRoute(builder: (_)=> BottomNavController()))).catchError((error)=>Fluttertoast.showToast(msg: "Error! Please try again"));
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h,),
                Text("Submit the form to continue",
                  style: TextStyle(
                  fontSize: 20.sp, color: AppColors.orange_accent
                ),
                ),
                Text("Your data is secured to us",
                  style: TextStyle(fontSize: 14.sp, color: AppColors.off_white),
                ),
                SizedBox(height: 15.h,),
                myTextField("Enter your name", TextInputType.text, _nameController),
                myTextField("Enter your Phone Number", TextInputType.number, _phoneController),
                TextField(
                  controller: _dobController,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: "date of birth",
                    suffixIcon: IconButton(
                      onPressed: () => _selectDateFromPicker(context),
                      icon: Icon(Icons.calendar_today_outlined),
                    )
                  ),
                ),
                TextField(
                  controller: _genderController,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: "choose your gender",
                    prefixIcon: DropdownButton<String>(
                      items: gender.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                          onTap: () {
                            setState(() {
                              _genderController.text = value;
                            });
                          },
                        );
                      }).toList(),
                      onChanged: (_) {},
                    ),
                  ),
                ),
                myTextField("Input your age", TextInputType.number, _ageController),
                SizedBox(height: 50.h,),
                customButton("Continue", ()=> sendDatatoFirebase()),
              ],
            ),
          ),
        ),
      )
    );
  }
}
