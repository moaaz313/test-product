class ProductModel {
  final String id;
  final String name;
  final String imageUrl;
  final int price;

  const ProductModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map, String docId) {
    return ProductModel(
      id: docId,
      name: map['name'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      price: map['price'] ?? 0,
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
