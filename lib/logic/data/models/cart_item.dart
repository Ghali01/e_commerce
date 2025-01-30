import 'dart:convert';

import 'package:e_commerce/logic/data/models/product.dart';

class CartItem {
  final int id;
  final int productId;
  final String name;
  final String image;
  final String price;
  final int quantity;
  CartItem({
    required this.id,
    required this.productId,
    required this.name,
    required this.image,
    required this.price,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll({'image': image});
    result.addAll({'price': price});
    result.addAll({'quantity': quantity});
    result.addAll({'product_id': productId});

    return result;
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
        id: map['id']?.toInt() ?? 0,
        name: map['name'] ?? '',
        image: map['image'] ?? '',
        price: map['price'] ?? '0.0',
        quantity: map['quantity']?.toInt() ?? 0,
        productId: map['product_id'] ?? 0);
  }

  String toJson() => json.encode(toMap());

  factory CartItem.fromJson(String source) =>
      CartItem.fromMap(json.decode(source));
  factory CartItem.fromProduct(Product product, int quantity) => CartItem(
      id: 0,
      productId: product.id,
      name: product.title,
      image: product.image,
      price: product.price,
      quantity: quantity);

  Map<String, dynamic> toApiMap() => {
        'productId': productId,
        'quantity': quantity,
      };
}
