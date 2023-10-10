class Pickups {
  final int id;
  final String title;
  final String? image;
  final String image64;

  Pickups({
    required this.id,
    required this.title,
    this.image,
    required this.image64,
  });

  factory Pickups.fromJson(Map<String, dynamic> json) {
    return Pickups(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      image: json['image'],
      image64: json['image_64'] ?? '',
    );
  }
}
