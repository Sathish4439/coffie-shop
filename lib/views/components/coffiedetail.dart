import 'package:coffie_shop/services/product.dart';
import 'package:coffie_shop/services/proiver.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CoffieDetailState extends State<CoffieDetail>
    with TickerProviderStateMixin {
  late TabController tabController;
  late int amt = int.parse(widget.price);

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    amt = int.parse(widget.price);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productprovider =
        Provider.of<ProductProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.arrow_back),
                    ),
                    IconButton(
                      onPressed: () {
                        var product = Product(
                          productdeiscrption: widget.des,
                          productname: widget.name,
                          productprice: amt.toString(),
                          productimage: widget.image);
                      productprovider.AddTofav(product);
                      },
                      icon: Icon(Icons.favorite_border),
                    )
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(widget.image),
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                height: MediaQuery.of(context).size.height / 2.5,
                width: MediaQuery.of(context).size.width,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.name,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                widget.des,
                style: GoogleFonts.poppins(
                  color: Colors.grey.shade800,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                "Coffie Size",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TabBar(
                onTap: (index) {
                  setState(() {
                    if (index == 0) {
                      amt = int.parse(widget.price) * 1; // For Small size
                    } else if (index == 1) {
                      amt = int.parse(widget.price) * 2; // For Medium size
                    } else if (index == 2) {
                      amt = int.parse(widget.price) * 3; // For Large size
                    }
                  });
                },
                dividerColor: Colors.grey.shade100,
                controller: tabController,
                indicatorWeight: 10,
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: Colors.black,
                indicatorColor: Colors.green,
                indicator: BoxDecoration(
                  color: Colors.brown,
                ),
                tabs: [
                  Tab(
                    text: "Small",
                  ),
                  Tab(
                    text: "Medium",
                  ),
                  Tab(
                    text: "Large",
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Description",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        "Price",
                        style: GoogleFonts.poppins(
                          color: Colors.grey.shade700,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "\u20B9$amt",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      var product = Product(
                          productdeiscrption: widget.des,
                          productname: widget.name,
                          productprice: amt.toString(),
                          productimage: widget.image);
                      productprovider.AddToCart(product);
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height / 15,
                      width: MediaQuery.of(context).size.width / 2,
                      decoration: BoxDecoration(
                        color: Colors.brown,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Add to cart",
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CoffieDetail extends StatefulWidget {
  final String image;
  final String price;
  final String des;
  final String name;

  CoffieDetail({
    Key? key,
    required this.image,
    required this.des,
    required this.name,
    required this.price,
  }) : super(key: key);

  @override
  State<CoffieDetail> createState() => CoffieDetailState();
}
