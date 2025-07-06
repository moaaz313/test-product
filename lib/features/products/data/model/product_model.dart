class ProductModel {
  final String name;
  final int price;
  final String imageUrl;

  const ProductModel({
    required this.name,
    required this.price,
    required this.imageUrl,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      name: map['name'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      price: (map['price'] is int) ? map['price'] : int.tryParse(map['price'].toString()) ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'price': price,
    };
  }
}
