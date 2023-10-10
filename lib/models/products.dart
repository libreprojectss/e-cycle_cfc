import 'dart:io';

class Product {
  String name;
  String description;
  File? image;

  Product({
    required this.name,
    required this.description,
    this.image,
  });
}
