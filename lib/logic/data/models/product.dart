import 'dart:convert';

class Product {
  final int id;
  final String title;
  final String image;
  final String price;
  final String description;
  final String category;
  Product({
    required this.id,
    required this.title,
    required this.image,
    required this.price,
    required this.description,
    required this.category,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'title': title});
    result.addAll({'image': image});
    result.addAll({'price': price});
    result.addAll({'description': description});
    result.addAll({'category': category});

    return result;
  }

  factory Product.fromMap(Map map) {
    return Product(
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      image: map['image'] ?? '',
      price: map['price']?.toString() ?? '',
      description: map['description'] ?? '',
      category: map['category'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));
}
