import 'dart:convert';

import 'package:easy_mart/modals/product_modal.dart';
import 'package:http/http.dart' as http;

class ProductApiService {

  final String baseUrl = "https://fakestoreapi.com/products";

 
  Future<List<ProductModel>> getAllProducts() async {

    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {

      List data = jsonDecode(response.body);

      return data.map((e) => ProductModel.fromJson(e)).toList();

    } else {
      throw Exception("Failed to load products");
    }
  }
  Future<List<ProductModel>> getAllCategories() async {

    final response = await http.get(Uri.parse("$baseUrl/categories"));

    if (response.statusCode == 200) {

      List data = jsonDecode(response.body);

      return data.map((e) => ProductModel.fromJson(e)).toList();

    } else {
      throw Exception("Failed to load products");
    }
  }
  Future<List<ProductModel>> getProductsByCategory(
      String category) async {
    final response = await http.get(
      Uri.parse("$baseUrl/category/$category"),
    );
    final List data = json.decode(response.body);
    return data.map((e) => ProductModel.fromJson(e)).toList();
  }
}
