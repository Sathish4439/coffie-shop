import 'package:coffie_shop/services/proiver.dart';
import 'package:coffie_shop/views/components/modified_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ModifiedText(data: "Cart"),
      ),
      body: Consumer<ProductProvider>(
        builder: (context, provider, child) {
          var products = provider.Products;
          return ListView.builder(
              itemCount: products.length,
              itemBuilder: ((context, index) {
                var product = products[index];
                return ListTile(
                    leading: CircleAvatar(
                      child: Image.network(
                        product.productimage,
                        fit: BoxFit.fill,
                      ),
                    ),
                    title: ModifiedText(data: product.productname),
                    subtitle:
                        ModifiedText(data: "price : " + product.productprice),
                    trailing: IconButton(
                        onPressed: () {
                          setState(() {
                            provider.RemoveFromCart(product);
                          });
                        },
                        icon: Icon(Icons.delete)));
              }));
        },
      ),
    );
  }
}
