import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:test_product/features/products/data/model/product_model.dart';

class ProductRepo {
  final FirebaseFirestore _firestore;

  ProductRepo({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<List<ProductModel>> getAllProducts() async {
    try {
      final querySnapshot = await _firestore.collection('products').get();
      print("📦 Fetched docs: ${querySnapshot.docs.length}"); // أضف السطر ده مؤقتًا
      print("📛 Current Firebase Project ID: ${Firebase.app().options.projectId}");

      return querySnapshot.docs
          .map((doc) => ProductModel.fromMap(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch products: $e');
    }
  }

  // Get Products in price range
  Future<List<ProductModel>> getProductsInRange(
    int minPrice,
    int maxPrice,
  ) async {
    try {
      final querySnapshot = await _firestore
          .collection('products')
          .where('price', isGreaterThanOrEqualTo: minPrice)
          .where('price', isLessThanOrEqualTo: maxPrice)
          .get();

      return querySnapshot.docs
          .map((doc) => ProductModel.fromMap(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch filtered products: $e');
    }
  }
}
