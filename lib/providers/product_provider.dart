import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:client_shop/models/product.dart';

class ProductProvider with ChangeNotifier {
  static List<Product> _products = [];
  String search = '';
  SizePrices selectedSize;
  int selectedIndex = 0;

  List<Product> get products {
    if (search.isNotEmpty) {
      return _products
          .where((element) => element.productName.contains(search))
          .toList();
    }
    return _products;
  }

  Product getProductData({String productId}) {
    Product prod = _products.firstWhere((element) => element.id == productId);
    return prod;
  }

  String get keyword {
    return search;
  }

  void setSelectedSizeIndex({Product product, int index}) {
    selectedIndex = index;
    selectedSize = product.sizePrices[index];
    notifyListeners();
  }

  void resetSelectedIndexes({Product product}) {
    selectedIndex = 0;
    selectedSize = product.sizePrices[0];
  }

  int get selectedSizeIndex {
    return selectedIndex;
  }

  SizePrices get selectedSizePrice {
    return selectedSize;
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
