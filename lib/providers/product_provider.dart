import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:client_shop/models/product.dart';

class ProductProvider with ChangeNotifier {
  static List<Product> _products = [];
  String search = '';

  List<Product> get products {
    if (search.isNotEmpty) {
      return _products
          .where((element) => element.productName.contains(search))
          .toList();
    }
    return _products;
  }

  String get keyword {
    return search;
  }

  static Future<void> initProducts() async {
    CollectionReference productRef =
        FirebaseFirestore.instance.collection('products');
    QuerySnapshot prodSnapshot = await productRef.get();
    List<Product> list = [];
    prodSnapshot.docs.forEach((element) {
      Product product = Product.fromJson(element.data());
      if (product.status) {
        list.add(product);
      }
    });
    _products = list;
  }

  Future<void> setProducts() async {
    CollectionReference productRef =
        FirebaseFirestore.instance.collection('products');
    QuerySnapshot prodSnapshot = await productRef.get();
    List<Product> list = [];
    prodSnapshot.docs.forEach((element) {
      Product product = Product.fromJson(element.data());
      if (product.status) {
        list.add(product);
      }
    });
    _products = list;
    notifyListeners();
  }

  void startSearch({keyword}) {
    search = keyword;
    notifyListeners();
  }

  void clearSearch() {
    search = '';
    notifyListeners();
  }
}
