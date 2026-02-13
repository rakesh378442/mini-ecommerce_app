import 'package:easy_mart/modals/category_model.dart';
import 'package:easy_mart/services/category_api_service.dart';
import 'package:flutter/material.dart';

class CategoryProvider extends ChangeNotifier {
  List<CategoryModel> _categories = [];
  bool _isLoading = false;

  List<CategoryModel> get categories => _categories;

  bool get isLoading => _isLoading;

  Future<void> fetchCategories() async {
    _isLoading = true;
    notifyListeners();

    try {
      final apiCategories = await CategoryApi.fetchCategories();

      _categories = [CategoryModel(id: "all", name: "All"), ...apiCategories];
    } catch (e) {
      debugPrint("Category error: $e");
    }

    _isLoading = false;
    notifyListeners();
  }
}
