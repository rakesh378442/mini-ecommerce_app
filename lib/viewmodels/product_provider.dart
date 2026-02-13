import 'package:easy_mart/modals/product_modal.dart';
import 'package:easy_mart/services/product_api.dart';
import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier {
  final ProductApiService apiService = ProductApiService();

  int selectedIndex = 0;
  int quantity = 1;

  List<ProductModel> allProducts = [];   // MASTER LIST
  List<ProductModel> productList = [];   // UI LIST
  List<ProductModel> cartData = [];

  bool isLoading = false;
  bool isSearching = false;

  String _selectedCategory = "All";

  void changeTab(int index) {
    selectedIndex = index;
    notifyListeners();
  }

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
    try {
      isLoading = true;
      notifyListeners();

      allProducts = await apiService.getAllProducts();
      productList = List.from(allProducts);

    } catch (e) {
      debugPrint("Fetch products error: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void filterByCategory(String category) {
    _selectedCategory = category;

    if (category == "All") {
      productList = List.from(allProducts);
    } else {
      productList = allProducts
          .where((p) => p.category.toLowerCase() == category.toLowerCase())
          .toList();
    }

    notifyListeners();
  }

  void searchProducts(String value) async {
    isSearching = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 300));

    List<ProductModel> baseList =
    _selectedCategory == "All"
        ? allProducts
        : allProducts
        .where((p) =>
    p.category.toLowerCase() ==
        _selectedCategory.toLowerCase())
        .toList();

    if (value.trim().isEmpty) {
      productList = baseList;
    } else {
      productList = baseList.where((product) {
        return product.title
            .toLowerCase()
            .contains(value.toLowerCase());
      }).toList();
    }

    isSearching = false;
    notifyListeners();
  }

  void addToCart(ProductModel product) {
    cartData.add(product);
    notifyListeners();
  }
}