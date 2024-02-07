import 'dart:io';

import 'package:coffie_shop/services/db.dart';
import 'package:coffie_shop/views/Mainpage.dart';
import 'package:coffie_shop/views/components/modified_text.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final TextEditingController prodName = TextEditingController();
  final TextEditingController prodDis = TextEditingController();
  final TextEditingController prodImg = TextEditingController();
  final TextEditingController prodPrice = TextEditingController();

  @override
  Widget build(BuildContext context) {
    File? _selectedImg;
    Future picimagefromgralary() async {
      final returnedimg =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      setState(() {
        if (returnedimg == null) return;
        _selectedImg = File(returnedimg!.path);
      });
    }

    Future picimagefromcamera() async {
      final returnedimg =
          await ImagePicker().pickImage(source: ImageSource.camera);
      setState(() {
        if (returnedimg == null) return;
        _selectedImg = File(returnedimg!.path);
      });
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        title: ModifiedText(data: "Add Products"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {
                Get.to(Mainpage());
              },
              icon: Icon(Icons.cancel),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: prodName,
                decoration: InputDecoration(
                  labelText: "Product Name",
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: prodPrice,
                decoration: InputDecoration(
                  labelText: "Product Price",
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: prodDis,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: "Product Description",
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: prodImg,
                decoration: InputDecoration(
                  labelText: "Product Image",
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextButton(
                    onPressed: () {
                      picimagefromgralary();
                    },
                    child: Text("Pick image from galary")),
              ),
              SizedBox(height: 20),
              Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                      onPressed: () {}, child: Text("Pick Image from camera"))),
              SizedBox(height: 20),
              _selectedImg != null
                  ? Image.file(_selectedImg!)
                  : Text("Please selece the image"),
              InkWell(
                onTap: () async {
                  String id = randomAlpha(10);
                  Map<String, dynamic> productInfo = {
                    "Name": prodName.text,
                    "price": prodPrice.text,
                    "Description":
                        prodDis.text, // Changed to match Firestore key
                    "Id": id,
                    "image": prodImg.text,
                  };
                  await DataBaseMethods().AddProductToDb(productInfo, id).then(
                      (value) => Fluttertoast.showToast(
                          msg: "added Succesfully",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0));
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: ModifiedText(data: "Add Product"),
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
