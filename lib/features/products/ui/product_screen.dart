import 'package:flutter/material.dart';
import 'package:test_product/features/products/data/model/product_model.dart';
import 'widgets/product_item.dart';
import 'widgets/price_slider.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  RangeValues _currentRange = const RangeValues(100, 1000);

  // بيانات وهمية مؤقتة
  final List<ProductModel> allProducts = [
    ProductModel(
      id: '1',
      name: 'Denim Jacket',
      imageUrl: 'https://via.placeholder.com/150',
      price: 600,
    ),
    ProductModel(
      id: '2',
      name: 'Leather Bag',
      imageUrl: 'https://via.placeholder.com/150',
      price: 850,
    ),
    ProductModel(
      id: '3',
      name: 'Sneakers',
      imageUrl: 'https://via.placeholder.com/150',
      price: 400,
    ),
    ProductModel(
      id: '4',
      name: 'Silk Scarf',
      imageUrl: '',
      price: 150,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // فلترة المنتجات بالرنج
    final filteredProducts = allProducts.where((product) {
      return product.price >= _currentRange.start &&
          product.price <= _currentRange.end;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        leading: const BackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // سلايدر
            PriceSlider(
              min: 100,
              max: 1000,
              currentRangeValues: _currentRange,
              onChanged: (val) {
                setState(() {
                  _currentRange = val;
                });
              },
            ),

            const SizedBox(height: 12),

            // المنتجات
            Expanded(
              child: ListView.builder(
                itemCount: filteredProducts.length,
                itemBuilder: (_, index) =>
                    ProductItem(product: filteredProducts[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
