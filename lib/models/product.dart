// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Product {
  final int id;
  final String name;
  final String image;
  final String description;
  final double price;
  int quantity;

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.price,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'image': image,
      'description': description,
      'price': price,
      'quantity': quantity,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as int,
      name: map['name'] as String,
      image: map['image'] as String,
      description: map['description'] as String,
      price: map['price'] as double,
      quantity: map['quantity'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);
}

var allProduct = [
  Product(
    id: 1,
    name: 'Mie Ayam',
    image: 'assets/makanan/mie_ayam.jpg',
    description: 'Mie ayam yang terbuat dari mie dan ada ayamnya',
    price: 18000.0,
    quantity: 1,
  ),
  Product(
    id: 2,
    name: 'Nasi Goreng',
    image: 'assets/makanan/nasi_goreng.jpg',
    description: 'Nasi goreng spesial dengan telor',
    price: 18000.0,
    quantity: 1,
  ),
];
