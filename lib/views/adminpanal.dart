import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffie_shop/services/db.dart';
import 'package:coffie_shop/views/addproduct.dart';
import 'package:coffie_shop/views/components/modified_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'Mainpage.dart';

class Adminpanal extends StatefulWidget {
  Adminpanal({Key? key}) : super(key: key);

  @override
  State<Adminpanal> createState() => _AdminpanalState();
}

class _AdminpanalState extends State<Adminpanal> {
  Stream<QuerySnapshot>? productStream;

  final TextEditingController prodName = TextEditingController();
  final TextEditingController prodDis = TextEditingController();
  final TextEditingController prodImg = TextEditingController();
  final TextEditingController prodPrice = TextEditingController();

  void getProductOnLoad() async {
    productStream = await DataBaseMethods().GetProductDeails();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getProductOnLoad();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: productStream != null
          ? StreamBuilder(
              stream: productStream,
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(child: CircularProgressIndicator());
                  default:
                    if (snapshot.data!.docs.isEmpty) {
                      return Text('No data available');
                    }
                    return ListView.separated(
                      separatorBuilder: ((context, index) {
                        return Divider();
                      }),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot ds = snapshot.data!.docs[index];
                        return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: CircleAvatar(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    ds["image"],
                                    fit: BoxFit.fill,
                                    height: 150,
                                  ),
                                ),
                              ),
                              title: ModifiedText(data: ds["Name"]),
                              subtitle:
                                  ModifiedText(data: "Price : " + ds["price"]),
                              trailing: SizedBox(
                                width: 100,
                                child: Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          prodName.text = ds["Name"];
                                          prodDis.text = ds["Description"];
                                          prodImg.text = ds["image"];
                                          prodPrice.text = ds["price"];

                                          EditproductDetails(ds["Id"]);
                                        },
                                        icon: Icon(Icons.edit)),
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.delete))
                                  ],
                                ),
                              ),
                            ));
                      },
                    );
                }
              },
            )
          : Center(child: CircularProgressIndicator()),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Get.to(AddProduct());
          }),
    );
  }

  Future EditproductDetails(String id) async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height / 1.5,
                child: Column(children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.cancel),
                      ),
                      Center(
                        child: Text("Edit"),
                      )
                    ],
                  ),
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
                  InkWell(
                    onTap: () async {
                      Map<String, dynamic> productInfo = {
                        "Name": prodName.text,
                        "price": prodPrice.text,
                        "Description":
                            prodDis.text, // Changed to match Firestore key
                        "Id": id,
                        "image": prodImg.text,
                      };
                      await DataBaseMethods()
                          .UpdateproductDetails(id, productInfo)
                          .then((value) => Navigator.pop(context));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 30,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(12)),
                        child: Center(
                          child: ModifiedText(data: "Update"),
                        ),
                      ),
                    ),
                  )
                ]),
              ),
            ),
          );
        });
  }
}
