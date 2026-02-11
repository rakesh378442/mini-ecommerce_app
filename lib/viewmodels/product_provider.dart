import 'package:easy_mart/modals/product_modal.dart';
import 'package:easy_mart/services/product_api.dart';
import 'package:flutter/cupertino.dart';

class ProductProvider extends ChangeNotifier {
  final ProductApiService apiService = ProductApiService();

  List<ProductModel> productList = [];
  List<ProductModel> allProducts = [];
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

  // ---------------- Fetch All ----------------
  Future<void> fetchProducts() async {
    isLoading = true;
    notifyListeners();

    try {
      allProducts = await apiService.getAllProducts();
      productList = allProducts;
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
      allProducts = await apiService.getProductsByCategory(category);
      productList = allProducts;
    } catch (e) {
      debugPrint("Fetch category error: $e");
    }

    isLoading = false;
    notifyListeners();
  }


  void searchProducts(String value) {
    if (value.isEmpty) {
      productList = allProducts;
    } else {
      productList = allProducts.where((product) {
        return product.title
            .toLowerCase()
            .contains(value.toLowerCase());
      }).toList();
    }

    notifyListeners();
  }


  void addToCart(ProductModel product) {
    cartData.add(product);
    notifyListeners();
  }
}
