import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class DataBaseMethods {
  Future AddProductToDb(Map<String, dynamic> productinfo, String id) async {
    return await FirebaseFirestore.instance
        .collection("product")
        .doc(id)
        .set(productinfo);
  }

  Future<Stream<QuerySnapshot>> GetProductDeails() async {
    return FirebaseFirestore.instance.collection("product").snapshots();
  }

  Future UpdateproductDetails(
      String id, Map<String, dynamic> ProductInfo) async {
    return await FirebaseFirestore.instance
        .collection("product")
        .doc(id)
        .update(ProductInfo);
  }
}
