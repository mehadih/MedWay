import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medway/const/app_colors.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController? _nameController;
  TextEditingController? _phoneController;
  TextEditingController? _ageController;

  setTextFieldData(data) {
    return Column(
      children: [
        TextField(
          controller: _nameController =
              TextEditingController(text: data['name']),
          decoration: InputDecoration(
              labelText: "Name",
              labelStyle: TextStyle(
                  color: AppColors.orange_accent,
                  fontSize: 24,
                  fontWeight: FontWeight.w500),
              icon: Icon(
                Icons.person,
                color: AppColors.orange_accent,
                size: 30,
              )),
        ),
        TextField(
          controller: _phoneController =
              TextEditingController(text: data['phone']),
          decoration: InputDecoration(
              labelText: "Phone",
              labelStyle: TextStyle(
                  color: AppColors.orange_accent,
                  fontSize: 24,
                  fontWeight: FontWeight.w400),
              icon: Icon(
                Icons.phone_in_talk_sharp,
                color: AppColors.orange_accent,
                size: 30,
              )),
        ),
        TextField(
          controller: _ageController = TextEditingController(text: data['age']),
          decoration: InputDecoration(
              labelText: "Age",
              labelStyle: TextStyle(
                  color: AppColors.orange_accent,
                  fontSize: 24,
                  fontWeight: FontWeight.w500),
              icon: Icon(
                Icons.calendar_month,
                color: AppColors.orange_accent,
                size: 30,
              )),
        ),
        SizedBox(
          height: 25,
        ),
        ElevatedButton(
          onPressed: () => updateData(),
          child: Text("Update"),
          style: ElevatedButton.styleFrom(
              primary: AppColors.orange_accent,
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        )
      ],
    );
  }

  updateData() {
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("Users Information");
    return _collectionRef.doc(FirebaseAuth.instance.currentUser!.email).update({
      "name": _nameController!.text,
      "phone": _phoneController!.text,
      "age": _ageController!.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.orange_accent,
        elevation: 0,
        title: Text(
          "My Profile",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("Users Information")
              .doc(FirebaseAuth.instance.currentUser!.email)
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            var data = snapshot.data;
            if (data == null) {
              return Center(child: CircularProgressIndicator());
            }
            return setTextFieldData(data);
          },
        ),
      )),
    );
  }
}
