import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medway/const/app_colors.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  TextEditingController ?_nameController;
  TextEditingController ?_phoneController;
  TextEditingController ?_dobController;
  TextEditingController ?_genderController;
  List<String> gender = ["Male", "Female", "Others"];


  setTextFieldData(data){
    return Column(
      children: [
        TextFormField(
          controller: _nameController = TextEditingController(text: data['name']),
        ),
        TextFormField(
          controller: _phoneController = TextEditingController(text: data['phone']),
        ),
        TextFormField(
          controller: _genderController = TextEditingController(text: data['gender']),
          decoration: InputDecoration(
            prefixIcon: DropdownButton<String>(
              items: gender.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: new Text(value),
                  onTap: () {
                    setState(() {
                      _genderController!.text = value;
                    });
                  },
                );
              }).toList(),
              onChanged: (_) {},
            ),
          ),
        ),
        TextFormField(
          controller: _dobController = TextEditingController(text: data['dob']),
          decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: () => _selectDateFromPicker(context),
                icon: Icon(Icons.calendar_today_outlined),
              )
          ),
        ),
        ElevatedButton(onPressed: ()=>updateData(), child: Text("Update"))
      ],
    );
  }

  updateData(){
    CollectionReference _collectionRef = FirebaseFirestore.instance.collection("Users Information");
    return _collectionRef.doc(FirebaseAuth.instance.currentUser!.email).update(
        {
          "name": _nameController!.text,
          "phone": _phoneController!.text,
          "gender": _genderController!.text,
          "dob": _dobController!.text,
        }
        );
  }

  Future<void> _selectDateFromPicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(DateTime.now().year - 20),
      firstDate: DateTime(DateTime.now().year - 30),
      lastDate: DateTime(DateTime.now().year),
    );
    if (picked != null)
      setState(() {
        _dobController?.text = "${picked.day}/ ${picked.month}/ ${picked.year}";
      });
  }

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
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Users Information").doc(FirebaseAuth.instance.currentUser!.email).snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            var data = snapshot.data;
            if (data==null){
              return Center(child: CircularProgressIndicator());
            }
            return setTextFieldData(data);
          },
        ),
      )),
    );
  }
}
