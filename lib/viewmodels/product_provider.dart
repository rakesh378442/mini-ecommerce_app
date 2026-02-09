import 'package:easy_mart/modals/product_modal.dart';
import 'package:easy_mart/services/product_api.dart';
import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier {
  final ProductApiService apiService = ProductApiService();

  List<ProductModel> productList = [];
  List<ProductModel> cartData = [];

  bool isLoading = false;


  int quantity = 1;

  void incrementQuantity() {
    quantity++;
    notifyListeners();
  }

  void decrementQuantity() {
    if (quantity > 1) {
      quantity--;
      notifyListeners();
    }
  }

  void resetQuantity() {
    quantity = 1;
    notifyListeners();
  }

  Future<void> fetchProducts() async {
    isLoading = true;
    notifyListeners();

    try {
      productList = await apiService.getAllProducts();
    } catch (e) {
      debugPrint("Fetch all products error: $e");
    }

    isLoading = false;
    notifyListeners();
  }


  Future<void> fetchProductsByCategory(String category) async {
    isLoading = true;
    notifyListeners();

    try {
      productList =
      await apiService.getProductsByCategory(category);
    } catch (e) {
      debugPrint("Fetch category error: $e");
    }

    isLoading = false;
    notifyListeners();
  }

  void addToCart(ProductModel product) {
    cartData.add(product);
    notifyListeners();
  }
}