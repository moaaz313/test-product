import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_product/features/products/data/repo/product_repo.dart';
import 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepo repository;

  ProductCubit(this.repository) : super(ProductInitial());

  Future<void> fetchAllProducts() async {
    emit(ProductLoading());
    try {
      final products = await repository.getAllProducts();
      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  // Fetch products by price range
  Future<void> filterProductsByRange(int minPrice, int maxPrice) async {
    emit(ProductLoading());
    try {
      final filtered = await repository.getProductsInRange(minPrice, maxPrice);
      emit(ProductLoaded(filtered));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
}
