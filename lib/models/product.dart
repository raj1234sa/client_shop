class Product {
  String id;
  String productName;
  bool status;
  bool isHotProduct;
  bool isNewArrival;
  String description;
  String imageUrl;
  String priceMethod;
  List<SizePrices> sizePrices;

  Product({
    this.id,
    this.productName,
    this.status,
    this.isHotProduct,
    this.isNewArrival,
    this.description,
    this.imageUrl,
    this.priceMethod,
    this.sizePrices,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['productName'];
    status = json['status'];
    isHotProduct = json['isHotProduct'];
    isNewArrival = json['isNewArrival'];
    description = json['description'];
    imageUrl = json['imageUrl'];
    priceMethod = json['priceMethod'];
    if (json['sizePrices'] != null) {
      sizePrices = new List<SizePrices>();
      json['sizePrices'].forEach((v) {
        sizePrices.add(new SizePrices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['productName'] = this.productName;
    data['status'] = this.status;
    data['isHotProduct'] = this.isHotProduct;
    data['isNewArrival'] = this.isNewArrival;
    data['description'] = this.description;
    data['imageUrl'] = this.imageUrl;
    data['priceMethod'] = this.priceMethod;
    if (this.sizePrices != null) {
      data['sizePrices'] = this.sizePrices.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SizePrices {
  String price;
  String size;

  SizePrices({this.price, this.size});

  SizePrices.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price'] = this.price;
    data['size'] = this.size;
    return data;
  }
}
