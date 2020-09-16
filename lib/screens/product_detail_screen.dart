import 'package:client_shop/models/product.dart';
import 'package:client_shop/providers/product_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;
  final bool fromNotification;

  ProductDetailScreen({@required this.product, this.fromNotification = false});

  @override
  Widget build(BuildContext context) {
    ProductProvider prodProvider = Provider.of<ProductProvider>(context);
    if (fromNotification) {
      prodProvider.setProducts();
    }
    List<SizePrices> sizePrices = product.sizePrices;
    return Scaffold(
      appBar: AppBar(
        title: Text(product.productName),
      ),
      body: RefreshIndicator(
        onRefresh: () => prodProvider.setProducts(),
        child: ListView(
          children: [
            Container(
              height: 320,
              child: Image.network(
                product.imageUrl,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 15,
              ),
              child: Text(
                product.productName,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              children: sizePrices.map((size) {
                int index = sizePrices.indexOf(size);
                return GestureDetector(
                  onTap: () => prodProvider.setSelectedSizeIndex(
                    index: index,
                    product: product,
                  ),
                  child: Container(
                    margin: index == 0
                        ? EdgeInsets.only(
                            right: 10,
                            left: 20,
                          )
                        : (index == sizePrices.length - 1)
                            ? EdgeInsets.only(left: 10)
                            : EdgeInsets.symmetric(horizontal: 10),
                    padding: EdgeInsets.symmetric(
                      vertical: 25,
                      horizontal: 20,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: prodProvider.selectedIndex == index
                          ? Colors.blue[100]
                          : Colors.white,
                      border: Border.all(
                        color: prodProvider.selectedIndex == index
                            ? Colors.blue[900]
                            : Colors.white,
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          size.size,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          size.price,
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 15,
              ),
              child: Text(
                product.description,
              ),
            ),
            RaisedButton.icon(
              color: Theme.of(context).primaryColor,
              onPressed: () {},
              icon: Icon(
                Icons.shopping_cart,
                color: Theme.of(context).primaryTextTheme.button.color,
              ),
              label: Text(
                "Add to Cart",
                style: TextStyle(
                  color: Theme.of(context).primaryTextTheme.button.color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
