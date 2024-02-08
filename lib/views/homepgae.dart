import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffie_shop/services/db.dart';
import 'package:coffie_shop/services/product.dart';
import 'package:coffie_shop/services/proiver.dart';
import 'package:coffie_shop/views/adminpanal.dart';
import 'package:coffie_shop/views/components/coffiedetail.dart';
import 'package:coffie_shop/views/profilepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:searchfield/searchfield.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final TextEditingController prodName = TextEditingController();
  final TextEditingController prodDis = TextEditingController();
  final TextEditingController prodImg = TextEditingController();
  final TextEditingController prodPrice = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final productprovider =
        Provider.of<ProductProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
            future: getProductOnLoad(),
            builder: (context, AsyncSnapshot<Stream<QuerySnapshot>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data == null) {
                return Text('No data available');
              } else {
                return StreamBuilder(
                  stream: snapshot.data,
                  builder:
                      (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                    if (streamSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (streamSnapshot.hasError) {
                      return Text('Stream Error: ${streamSnapshot.error}');
                    } else if (streamSnapshot.data == null ||
                        streamSnapshot.data!.docs.isEmpty) {
                      return Text('No data available');
                    } else {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Good Morning",
                                style: GoogleFonts.poppins(),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(Profilepage());
                                },
                                child: Icon(Icons.person),
                              ),
                            ],
                          ),
                          Text(
                            "Find Your Ideal cup of coffee.",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            child: SearchField(
                              searchInputDecoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: "Search",
                                prefixIcon: Icon(Icons.search),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                              ),
                              suggestions: [
                                for (var doc in streamSnapshot.data!.docs)
                                  doc['Name']
                              ]
                                  .map((e) =>
                                      SearchFieldListItem(e, child: Text(e)))
                                  .toList(),
                            ),
                          ),
                          SizedBox(height: 10),
                          Expanded(
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: streamSnapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                DocumentSnapshot ds =
                                    streamSnapshot.data!.docs[index];
                                if (index < 2) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      onTap: () {
                                        Get.to(CoffieDetail(
                                          image: ds["image"],
                                          price: ds["price"],
                                          name: ds["Name"],
                                          des: ds["Description"],
                                        ));
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white70,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        width: 200,
                                        child: FittedBox(
                                          child: Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    child: Container(
                                                      height: 150,
                                                      width: 150,
                                                      child: Image.network(
                                                        ds["image"],
                                                        fit: BoxFit.cover,
                                                        height: 150,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 10),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "${ds["Name"]}",
                                                        style:
                                                            GoogleFonts.poppins(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                      ),
                                                      SizedBox(height: 5),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "Price: ${ds["price"]}",
                                                            style: GoogleFonts
                                                                .poppins(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                          ),
                                                          SizedBox(
                                                            width: 50,
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              var product = Product(
                                                                  productdeiscrption: ds[
                                                                      "Description"],
                                                                  productname: ds[
                                                                      "name"],
                                                                  productprice: ds[
                                                                      "price"],
                                                                  productimage:
                                                                      ds["image"]);
                                                              productprovider
                                                                  .AddToCart(
                                                                      product);
                                                            },
                                                            child: Container(
                                                              height: 30,
                                                              width: 30,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12),
                                                                color: Colors
                                                                    .orange,
                                                              ),
                                                              child: Center(
                                                                child: Icon(
                                                                    Icons.add),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                return SizedBox.shrink();
                              },
                            ),
                          ),
                          Text(
                            "Exclusively for You",
                            style: GoogleFonts.poppins(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          Expanded(
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: streamSnapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                DocumentSnapshot ds =
                                    streamSnapshot.data!.docs[index];
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: FittedBox(
                                    child: InkWell(
                                      onTap: () {
                                        Get.to(CoffieDetail(
                                          image: ds["image"],
                                          price: ds["price"],
                                          name: ds["Name"],
                                          des: ds["Description"],
                                        ));
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  child: Container(
                                                    height: 150,
                                                    width: 150,
                                                    child: Image.network(
                                                      ds["image"],
                                                      fit: BoxFit.cover,
                                                      height: 150,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "${ds["Name"]}",
                                                        textAlign:
                                                            TextAlign.start,
                                                        style:
                                                            GoogleFonts.poppins(
                                                                fontSize: 25,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                      ),
                                                      SizedBox(height: 10),
                                                      Text(
                                                        ds["Description"],
                                                        textAlign:
                                                            TextAlign.center,
                                                        style:
                                                            GoogleFonts.poppins(
                                                                fontSize: 13),
                                                      ),
                                                      SizedBox(height: 10),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "Price: ${ds["price"]}",
                                                            style: GoogleFonts
                                                                .poppins(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                          ),
                                                          SizedBox(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  4),
                                                          InkWell(
                                                            onTap: () {},
                                                            child: Container(
                                                              height: 30,
                                                              width: 30,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12),
                                                                color: Colors
                                                                    .orange,
                                                              ),
                                                              child: Center(
                                                                child: Icon(
                                                                    Icons.add),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    }
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Future<Stream<QuerySnapshot>> getProductOnLoad() async {
    return DataBaseMethods().GetProductDeails();
  }
}
