import 'dart:io';

class Product {
  String name;
  String description;
  File? image;
  bool usable;

  Product({
    required this.name,
    required this.description,
    required this.usable,
    this.image,
  });
}
