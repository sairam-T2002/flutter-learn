import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductCart {
  String productName;
  String imageUrl;
  int? productId;
  int price;
  int categoryId;
  int count;
  ProductCart(
      {required this.productName,
      required this.imageUrl,
      required this.productId,
      required this.price,
      required this.categoryId,
      required this.count});
}

class CartNotifier extends StateNotifier<List<ProductCart>> {
  CartNotifier() : super([]);

  void addToCart(ProductCart product) {
    state = [...state, product];
  }

  void removeFromCart(int? productId) {
    state = [
      for (final product in state)
        if (product.productId != productId) product,
    ];
  }

  void updateQuantity(int? productId, int newCount) {
    state = [
      for (final product in state)
        if (product.productId == productId)
          ProductCart(
              productName: product.productName,
              productId: product.productId,
              price: product.price,
              categoryId: product.categoryId,
              count: newCount,
              imageUrl: product.imageUrl)
        else
          product,
    ];
  }
}

class CategoryNotifier extends StateNotifier<List<String>> {
  CategoryNotifier() : super([]);

  void addToCategory(String category) {
    state = [...state, category];
  }
}

class DefaultSearchImage extends StateNotifier<String> {
  DefaultSearchImage() : super('');

  void setDefaultImg(String imageUrl) {
    state = imageUrl;
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, List<ProductCart>>(
    (ref) => CartNotifier());

final categoryProvider = StateNotifierProvider<CategoryNotifier, List<String>>(
    (ref) => CategoryNotifier());

final defaultImgProvider = StateNotifierProvider<DefaultSearchImage, String>(
    (ref) => DefaultSearchImage());
