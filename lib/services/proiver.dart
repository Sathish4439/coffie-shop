import 'package:coffie_shop/services/product.dart';
import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> _product = [];

  List<Product> get Products => _product;

  List<Product> _favroite = [];

  List<Product> get faviroites => _favroite;

  void AddToCart(Product product) {
    Products.add(product);
    ChangeNotifier();
  }

  void RemoveFromCart(Product product) {
    Products.remove(product);
    ChangeNotifier();
  }
   void AddTofav(Product product) {
    faviroites.add(product);
    ChangeNotifier();
  }

  void RemoveFromFav(Product product) {
    faviroites.remove(product);
    ChangeNotifier();
  }
}
