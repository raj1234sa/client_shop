import 'package:client_shop/models/product.dart';
import 'package:client_shop/providers/product_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;
  final bool fromNotification;
  ProductDetailScreen({@required this.product, this.fromNotification = false});
  @override
  Widget build(BuildContext context) {
    if(fromNotification) {
      Provider.of<ProductProvider>(context).setProducts();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(product.productName),
      ),
    );
  }
}
