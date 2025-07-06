import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_product/features/products/logic/cubit/product_cubit.dart';
import 'package:test_product/features/products/logic/cubit/product_state.dart';
import 'widgets/product_item.dart';
import 'widgets/price_slider.dart';
import 'package:shimmer/shimmer.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  RangeValues _currentRange = const RangeValues(100, 1000);

  @override
  void initState() {
    super.initState();

    context.read<ProductCubit>().fetchAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        leading: const BackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            PriceSlider(
              min: 100,
              max: 1000,
              currentRangeValues: _currentRange,
              onChanged: (val) {
                setState(() {
                  _currentRange = val;
                });
                context.read<ProductCubit>().filterProductsByRange(
                  val.start.round(),
                  val.end.round(),
                );
              },
            ),
            Expanded(
              child: BlocBuilder<ProductCubit, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoading) {
                    return _buildShimmer();
                  } else if (state is ProductLoaded) {
                    final products = state.products;
                    if (products.isEmpty) {
                      return const Center(child: Text('No products found.'));
                    }
                    return ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (_, index) =>
                          ProductItem(product: products[index]),
                    );
                  } else if (state is ProductError) {
                    return Center(child: Text(state.message));
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmer() {
    return ListView.builder(
      itemCount: 6,
      itemBuilder: (_, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            height: 100,
            color: Colors.white,
          ),
        );
      },
    );
  }
}
