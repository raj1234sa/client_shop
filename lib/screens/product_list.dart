import 'dart:io';

import 'package:client_shop/models/product.dart';
import 'package:client_shop/providers/product_provider.dart';
import 'package:client_shop/screens/product_detail_screen.dart';
import 'package:client_shop/widgets/product_item.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductListScreen extends StatefulWidget {
  static final routeName = 'product_list_screen';

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  Future<void> refreshProducts(BuildContext context) async {
    await Provider.of<ProductProvider>(context, listen: false).setProducts();
  }

  final _searchController = TextEditingController();
  final _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    if (Platform.isIOS) {
      _firebaseMessaging.requestNotificationPermissions();
    }
    _firebaseMessaging.configure(
      onResume: (message) async {
        String prodId = message['data']['product'];
        await ProductProvider.initProducts();
        Product product = ProductProvider.getProductData(productId: prodId);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(
              product: product,
              fromNotification: true,
            ),
          ),
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final List<Product> products = productProvider.products;
    _firebaseMessaging.onTokenRefresh;

    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _searchController,
              onChanged: (value) {
                productProvider.startSearch(keyword: value);
              },
              decoration: InputDecoration(
                hintText: 'Search Products...',
                suffix: productProvider.search.isNotEmpty
                    ? GestureDetector(
                        onTap: () {
                          _searchController.text = '';
                          productProvider.clearSearch();
                          FocusScope.of(context).unfocus();
                        },
                        child: Icon(
                          Icons.clear,
                          color: Colors.red,
                        ),
                      )
                    : null,
              ),
            ),
            Expanded(
              child: Container(
                child: RefreshIndicator(
                  onRefresh: () => refreshProducts(context),
                  child: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                    },
                    child: GridView.builder(
                      padding: EdgeInsets.only(top: 20),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.6,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index) {
                        return ProductItem(
                          product: products[index],
                        );
                      },
                      itemCount: products.length,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
