import 'package:client_shop/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;
  ProductDetailScreen({@required this.product});
  @override
  Widget build(BuildContext context) {
    // final CollectionReference _viewRef =
    //     FirebaseFirestore.instance.collection('views');
    // _viewRef.doc(product.productId).get().then((value) async {
    //   if (value.data() == null) {
    //     await _viewRef.doc(product.productId).set({'view': 0});
    //   } else {
    //     print(value.data()['view']);
    //     int view = value.data()['view'] + 1;
    //     await _viewRef.doc(product.productId).set({'view': view});
    //   }
    // });
    return Scaffold(
      appBar: AppBar(
        title: Text(product.productName),
      ),
    );
  }
}
