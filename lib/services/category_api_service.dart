import 'dart:convert';
import 'package:easy_mart/modals/category_model.dart';
import 'package:http/http.dart' as http;

class CategoryApi {
  static const String _baseUrl =
      "https://fakestoreapi.com/products/categories";

  static Future<List<CategoryModel>> fetchCategories() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data
          .map((e) => CategoryModel.fromJson(e))
          .toList();
    } else {
      throw Exception("Failed to load categories");
    }
  }
}